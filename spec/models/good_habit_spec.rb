require 'rails_helper'

RSpec.describe Habit, type: :model do
  let(:text_max) { 400 }

  it "習慣名と効果、作成したユーザIDを入力すれば、モデルが有効になること" do
    expect(FactoryBot.build(:habit)).to be_valid
  end

  it "習慣名が重複していると、モデルが無効になること" do
    FactoryBot.create(:dup_name_habit)
    habit = FactoryBot.build(:habit)
    habit.valid?
    expect(habit.errors[:name]).to include("has already been taken")
  end

  it "習慣名がなければ、モデルが無効になること" do
    expect(FactoryBot.build(:habit, name: nil)).to be_invalid
  end
  it "習慣名がスペースだけならば、モデルが無効になること" do
    expect(FactoryBot.build(:habit, name: " ")).to be_invalid
  end
  
  it "作成したユーザIDが重複していると、モデルが無効になること" do
    FactoryBot.create(:dup_creating_id_habit)
    habit = FactoryBot.build(:habit)
    habit.valid?
    expect(habit.errors[:creating_user_id]).to include("has already been taken")
  end
  it "作成したユーザーIDがなければ、モデルが無効になること" do
    expect(FactoryBot.build(:habit, creating_user_id: nil)).to be_invalid
  end
  it "作成したユーザーIDがスペースだけならば、モデルが無効になること" do
    expect(FactoryBot.build(:habit, creating_user_id: " ")).to be_invalid
  end

  it "工夫の文字数が400文字を超えると、モデルが無効になること" do
    expect(FactoryBot.build(:habit, scheme: "1" * (text_max + 1))).to be_invalid
  end
end
