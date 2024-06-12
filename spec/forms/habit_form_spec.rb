require 'rails_helper'

RSpec.describe HabitForm, type: :model do
  let(:habit_form) { HabitForm.new }
  let(:scheme_text_max) { 400 }
  let(:name_text_max) { 20 }
  let(:period_for_effect_text_max) { 10 }
  before do
    habit_form.name = "habit"
    habit_form.effects = "キーワード1,キーワード2"
  end

  it "習慣名、効果があれば、フォームオブジェクトが有効になる" do
    habit_form.valid?
    expect(habit_form).to be_valid
  end

  # 習慣
  it "習慣名がなければ、フォームオブジェクトが無効になること" do
    habit_form.name = nil
    habit_form.valid?
    expect(habit_form).to be_invalid
  end
  it "習慣名が空白であれば、フォームオブジェクトが無効になること" do
    habit_form.name = " "
    habit_form.valid?
    expect(habit_form).to be_invalid
  end
  it "習慣名が20文字を超えると、フォームオブジェクトが無効になること" do
    habit_form.name = "s" * (name_text_max + 1)
    habit_form.valid?
    expect(habit_form).to be_invalid
  end
  it "スキームが400文字を超えると、フォームオブジェクトが無効になること" do
    habit_form.scheme = "1" * (scheme_text_max + 1)
    habit_form.valid?
    expect(habit_form).to be_invalid
  end
  it "「効果が出始める期間」が10文字を超えると、フォームオブジェクトが無効になること" do
    habit_form.period_for_effect = "1" * (period_for_effect_text_max + 1)
    habit_form.valid?
    expect(habit_form).to be_invalid
  end

  # 効果
  it "効果がなければ、フォームオブジェクトが無効になること" do
    habit_form.effects = nil
    habit_form.valid?
    expect(habit_form).to be_invalid
  end
  it "効果が空白であれば、フォームオブジェクトが無効になること" do
    habit_form.effects = " "
    habit_form.valid?
    expect(habit_form).to be_invalid
  end

end
