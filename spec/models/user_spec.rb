require 'rails_helper'

RSpec.describe User, type: :model do
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
  it "パスワードがなければ、テストが無効になること" do
    expect(FactoryBot.build(:user, password: nil)).to be_invalid
  end
  it "パスワードがスペースだけならば、無効になること" do
    expect(FactoryBot.build(:user, password: "  ")).to be_invalid
  end
end
