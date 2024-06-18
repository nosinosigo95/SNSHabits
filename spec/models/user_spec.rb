require 'rails_helper'

RSpec.describe User, type: :model do
  let(:password_min) { 6 }
  let(:password_max) { 128 }
  let(:intro_max) { 401 }

  it "名前とメールアドレス、パスワードがあれば、テストが有効になること" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "名前がなければ、テストが無効になること" do
    expect(FactoryBot.build(:user, name: nil)).to be_invalid
  end
  it "名前がスペースだけならば、テストが無効になること" do
    expect(FactoryBot.build(:user, name: "   ")).to be_invalid
  end
  it "重複した名前が登録されるとき、テストが無効になること" do
    FactoryBot.create(:user, name: "123", email: "123@example.com")
    user = FactoryBot.build(:user, name: "123", email: "e@example.com")
    user.valid?
    expect(user.errors[:name]).to include("はすでに存在します")
  end

  it "メールアドレスがなければ、テストが無効になること" do
    expect(FactoryBot.build(:user, email: nil)).to be_invalid
  end
  it "メールアドレスがスペースだけならば、テストが無効になること" do
    expect(FactoryBot.build(:user, email: "    ")).to be_invalid
  end
  it "形式が無効であるメールアドレスを登録しようとすると、テストが無効になること" do
    invalid_addresses = %w(
      user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com
    )
    invalid_addresses.each do |invalid_address|
      expect(FactoryBot.build(:user, email: invalid_address)).to be_invalid
    end
  end
  it "重複したメールアドレスが登録されるとき、テストが無効になること" do
    FactoryBot.create(:user, name: "sample", email: "example@example.com")
    user = FactoryBot.build(:user, name: "example", email: "example@example.com")
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
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

  it "自己紹介の文章が401文字以上ならば、テストが失敗すること" do
    expect(FactoryBot.build(:user, introduction: "1" * (intro_max + 1))).to be_invalid
  end
end
