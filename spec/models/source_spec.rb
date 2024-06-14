require 'rails_helper'

RSpec.describe Source, type: :model do
  it "URLが存在するとき、モデルは有効であること" do
    expect(FactoryBot.build(:source)).to be_valid
  end
  it "URLが空白であるとき、モデルは無効であること" do
    expect(FactoryBot.build(:source, url: " ")).to be_invalid
  end
  it "URLが存在しないとき、モデルは無効であること" do
    expect(FactoryBot.build(:source, url: nil)).to be_invalid
  end
end
