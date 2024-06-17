require 'rails_helper'

RSpec.describe Diary, type: :model do

  let (:description_max) { 600 }
  it "記述と作業時間、プライベートを入力すれば、モデルは有効になること" do
    expect(FactoryBot.build(:diary, private: true)).to be_valid
  end

  it "記述がなければ、モデルは無効になること" do
    expect(FactoryBot.build(:diary, description: nil, private: true)).to be_invalid
  end
  it "記述が空白ならば、モデルは無効になること" do
    expect(FactoryBot.build(:diary, description: " ", private: true)).to be_invalid
  end
  it "記述が600文字を超えるならば、モデルは無効になること" do
    expect(FactoryBot.build(:diary, description: "1" * (description_max + 1), private: true)).to be_invalid
  end

  it "作業時間がなければ、モデルは無効になること" do
    expect(FactoryBot.build(:diary, doing_time: nil, private: true)).to be_invalid
  end
  it "作業時間が空白ならば、モデルは無効になること" do
    expect(FactoryBot.build(:diary, doing_time: " ", private: true)).to be_invalid
  end
  it "作業時間のフォーマットが合っていなければ、モデルが無効になること" do
    diary = FactoryBot.build(:diary, private: true)
    invalid_doing_times = %w(001:00 01:000 01:01:00)
    invalid_doing_times.each do |invalid_doing_time|
      diary.doing_time= invalid_doing_time
      expect(diary).to be_invalid
    end
  end
  it "作業時間のフォーマットが合っていれば、モデルが有効になること" do
    diary = FactoryBot.build(:diary, private: true)
    valid_doing_times = %w(01:00 00:00 1:0)
    valid_doing_times.each do |valid_doing_time|
      diary.doing_time= valid_doing_time
      expect(diary).to be_valid
    end
  end
  
  it "プライベートがなければ、モデルは無効になること" do
    expect(FactoryBot.build(:diary, private: nil)).to be_invalid
  end
 
end
