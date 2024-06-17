require 'rails_helper'

RSpec.describe Diary, type: :model do

  let (:description_max) { 600 }
  it "記述と作業時間、プライベートを入力すれば、モデルは有効になること" do
    expect(FactoryBot.build(:diary)).to be_valid
  end

  it "記述がなければ、モデルは無効になること" do
    expect(FactoryBot.build(:diary, description: nil)).to be_invalid
  end
  it "記述が空白ならば、モデルは無効になること" do
    expect(FactoryBot.build(:diary, description: " ")).to be_invalid
  end
  it "記述が600文字を超えるならば、モデルは無効になること" do
    expect(FactoryBot.build(:diary, description: "1" * description_max)).to be_invalid
  end

  it "作業時間がなければ、モデルは無効になること" do
    expect(FactoryBot.build(:diary, doing_time: nil)).to be_invalid
  end
  it "作業時間が空白ならば、モデルは無効になること" do
    expect(FactoryBot.build(:diary, doing_time: " ")).to be_invalid
  end

  it "プライベートがなければ、モデルは無効になること" do
    expect(FactoryBot.build(:diary, private: nil)).to be_invalid
  end
  it "プライベートが空白ならば、モデルは無効になること" do
    expect(FactoryBot.build(:diary, private: " ")).to be_invalid
  end
end
