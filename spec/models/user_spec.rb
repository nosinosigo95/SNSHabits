require 'rails_helper'

RSpec.describe User, type: :model do
  let(:password_min) { 6 }
  let(:password_max) { 128 }

  it "名前とメールアドレス、パスワードがあれば、テストが有効になること" do
    expect(FactoryBot.build(:user)).to be_valid
  end
  it "名前がなければ、テストが無効になること" do
    expect(FactoryBot.build(:user, name: nil)).to be_invalid
  end
  it "名前がスペースだけならば、テストが無効になること" do
    expect(FactoryBot.build(:user, name: "   ")).to be_invalid
  end

  it "メールアドレスがなければ、テストが無効になること" do
    expect(FactoryBot.build(:user, email: nil)).to be_invalid
  end
  it "メールアドレスがスペースだけならば、テストが無効になること" do
    expect(FactoryBot.build(:user, email: "    ")).to be_invalid
  end
  it "形式が無効であるメールアドレスを登録しようとすると、テストが無効になること" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      expect(FactoryBot.build(:user, email: invalid_address)).to be_invalid
    end
  end
  it "重複したメールアドレスが登録されるとき、テストが無効になること" do
    User.create(
      name: "sample",
      email: "sample@sample.com",
      password: "1" * password_min
    )
    user = User.create(
      name: "example",
      email: "sample@sample.com",
      password: "1" * password_min
    )
    expect(user.errors.full_messages).to include("Email has already been taken")
  end

  it "パスワードがなければ、テストが無効になること" do
    expect(FactoryBot.build(:user, password: nil)).to be_invalid
  end
  it "パスワードがスペースだけならば、テストが無効になること" do
    expect(FactoryBot.build(:user, password: "  ")).to be_invalid
  end
  it "パスワードが5文字以下ならば、テストが無効になること" do
    expect(FactoryBot.build(:user, password: "1" * (password_min - 1))).to be_invalid
  end
  it "パスワードが129文字以上ならば、テストが無効になること" do
    expect(FactoryBot.build(:user, password: "1" * (password_max + 1))).to be_invalid
  end
end
