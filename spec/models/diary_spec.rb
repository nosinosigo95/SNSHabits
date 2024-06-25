require 'rails_helper'
require 'date'

RSpec.describe Diary, type: :model do
  let(:description_max) { 600 }
  let(:user_id) { 2 }
  let(:habit_id) { 1 }

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
    expect(FactoryBot.build(:diary, {
      description: "1" * (description_max + 1),
      private: true,
    })).to(be_invalid)
  end

  it "実行日がなければ、モデルは無効になること" do
    expect(FactoryBot.build(:diary, action_date: nil, private: true)).to be_invalid
  end
  it "実行日が今日より後ならば、モデルは無効になること" do
    tomorrow = Date.tomorrow.strftime("%F")
    expect(FactoryBot.build(:diary, action_date: tomorrow, private: true)).to be_invalid
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
      diary.doing_time = invalid_doing_time
      expect(diary).to be_invalid
    end
  end
  it "作業時間のフォーマットが合っていれば、モデルが有効になること" do
    diary = FactoryBot.build(:diary, private: true)
    valid_doing_times = %w(01:00 1:0)
    valid_doing_times.each do |valid_doing_time|
      diary.doing_time = valid_doing_time
      expect(diary).to be_valid
    end
  end
  it "実行時間が00:00であるならば、モデルが無効になること" do
    diary = FactoryBot.build(:diary, private: true)
    diary.doing_time = "00:00"
    diary.valid?
    expect(diary.errors[:doing_time]).to include("は1分以上にしてください")
  end

  it "プライベートがなければ、モデルは無効になること" do
    expect(FactoryBot.build(:diary, private: nil)).to be_invalid
  end

  it "レシーバがhabitとuserのidに合うデータを受けること" do
    FactoryBot.create(:diary, habit_id: habit_id, user_id: user_id)
    FactoryBot.create_list(:diary, 10)
    diaries = Diary.continuous_habits(habit_id, user_id)
    diaries.each do |diary|
      expect(diary.habit_id).to eq habit_id
      expect(diary.user_id).to eq user_id
    end
  end
  it "レシーバがuserのidに合うデータを受けること" do
    FactoryBot.create(:diary, user_id: user_id)
    FactoryBot.create_list(:diary, 10)
    diaries = Diary.index_for_user(user_id)
    diaries.each do |diary|
      expect(diary.user_id).to eq user_id
    end
  end
end
