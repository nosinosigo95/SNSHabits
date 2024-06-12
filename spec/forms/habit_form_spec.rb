require 'rails_helper'

RSpec.describe HabitForm, type: :model do
  let(:habit_form){ HabitForm.new }
  before do
    habit_form.name = "habit"
    habit_form.effects = "キーワード1,キーワード2"
  end
  
  it "習慣名、効果があれば、フォームオブジェクトが有効になる" do
    habit_form.valid?
    expect(habit_form).to be_valid
  end

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

  it "effectsがなければ、フォームオブジェクトが無効になること" do
    habit_form.effects = nil
    habit_form.valid?
    expect(habit_form).to be_invalid
  end
  it "effectsが空白であれば、フォームオブジェクトが無効になること" do
    habit_form.effects = " "
    habit_form.valid?
    expect(habit_form).to be_invalid
  end

end
