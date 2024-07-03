require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "コメントと習慣、ユーザーがあれば、モデルが有効になること" do
    expect(FactoryBot.build(:comment)).to be_valid
  end

  it "コメントがない場合、モデルが無効になること" do
    expect(FactoryBot.build(:comment, comment: nil)).to be_invalid
  end

  it "コメントが空白文字だけの場合、モデルが無効になること" do
    expect(FactoryBot.build(:comment, comment: " ")).to be_invalid
  end
end
