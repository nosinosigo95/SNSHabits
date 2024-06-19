require 'rails_helper'

RSpec.describe HabitIndexForm, type: :model do
  let(:habit_index_form) { HabitIndexForm.new }
  it "入力がなくても、フォームオブジェクトは有効にあること" do
    habit_index_form.valid?
    expect(habit_index_form).to be_valid
  end

  it "createdの入力が正しい形式ならば、フォームオブジェクトは有効であること" do
    valid_checkbox_values = %w(1 0)
    valid_checkbox_values.each do |valid_checkbox_value|
      habit_index_form.created = valid_checkbox_value
      expect(habit_index_form).to be_valid
    end
  end
  it "createdの入力が不正な形式ならば、フォームオブジェクトは有効であること" do
    invalid_checkbox_values = %w(a 3 あ)
    invalid_checkbox_values.each do |invalid_checkbox_value|
      habit_index_form.created = invalid_checkbox_value
      expect(habit_index_form).to be_invalid
    end
  end
end
