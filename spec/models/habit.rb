require 'rails_helper'

RSpec.describe Habit, type: :model do
  let(:habit_name) { "習慣1" }
  let(:effect_item) { "効果1" }
  let(:period_for_effect) { "3ヶ月" }
  let(:created) { "1" }
  let(:sort) { "created_at" }

  it "Habitクラスがsearch_allメソッドを呼ぶと、コミットされたすべての習慣を受け取ること" do
    FactoryBot.create_list(:habit, 10)
    habits = Habit.search_all
    habits.each do |habit|
      expect(habit.commit).to eq true
    end
  end

  it "Habitクラスがhabit_attrメソッドを呼ぶと、すべての習慣を取得すること" do
    habit_index = HabitIndexForm.new
    expected_habits = FactoryBot.create_list(:habit, 10, commit: true, challenge: false)
    search_habits = Habit.search_attr(habit_index, "", nil)
    expected_habits.each do |expected_habit|
      expect(search_habits).to include expected_habit
    end
  end
  it "Habitクラスがsearch_attrメソッドを呼ぶと、降順にソートされたものを取得すること" do
    habit_index = HabitIndexForm.new
    expected_habits = FactoryBot.create_list(:habit, 10, commit: true, challenge: false)
    expected_habits.sort! do |a, b|
      b.created_at <=> a.created_at
    end
    target_habits = Habit.search_attr(habit_index, sort, nil)
    for i in (0..expected_habits.count - 1)
      expect(target_habits[i]).to eq expected_habits[i]
    end
  end
  it "Habitクラスがsearch_attrメソッドを呼ぶと、検索に合う結果を受け取ること" do
    habit_index = HabitIndexForm.new(attributes:{name: habit_name, effect_item: effect_item, period_for_effect: period_for_effect})
    expected_habits = FactoryBot.create_list(:habit, 10, commit: true, challenge: false)
    target_habits = Habit.search_attr(habit_index, "", nil)
    target_habits.each do |target_habit|
      expect(target_habit.name).to eq habit_name
      expect(target_habit.effect_item).to eq effect_item
      expect(target_habit.period_for_effect).to eq period_for_effect
    end
  end
  it "Habitクラスがsearch_attrメソッドを呼ぶと、検索に合う結果を降順に受け取ること" do
    habit_index = HabitIndexForm.new(attributes:{name: habit_name})
    expected_habits = FactoryBot.create_list(:habit, 10, name: habit_name, commit: true, challenge: false)
    expected_habits.sort! do |a, b|
      b.created_at <=> a.created_at
    end
    target_habits = Habit.search_attr(habit_index, sort, nil)
    for i in (0..expected_habits.count - 1)
      expect(target_habits[i]).to eq expected_habits[i]
    end
  end
end
