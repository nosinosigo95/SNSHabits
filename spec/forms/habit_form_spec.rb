require 'rails_helper'

RSpec.describe HabitForm, type: :model do
  let(:habit_form) { HabitForm.new }
  let(:scheme_text_max) { 400 }
  let(:name_text_max) { 20 }
  let(:period_for_effect_text_max) { 10 }
  before do
    habit_form.name = "habit"
    habit_form.effects = "キーワード1,キーワード2"
    habit_form.circumstance = "challenge"
    habit_form.scheme = "工夫 工夫"
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
  it "スキームがなければ、フォームオブジェクトが無効になること" do
    habit_form.name = nil
    habit_form.valid?
    expect(habit_form).to be_invalid
  end
  it "スキームが空白であれば、フォームオブジェクトが無効になること" do
    habit_form.name = " "
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
  it "「状況が」がコミットか挑戦中であるならば、フォームオブジェクトが有効になること" do
    valid_circumstances = %w(commit challenge)
    valid_circumstances.each do |valid_circumstance|
      habit_form.circumstance = valid_circumstance
      habit_form.valid?
      expect(habit_form).to be_valid
    end
  end
  it "「状況が」がコミットか挑戦中でないならば、フォームオブジェクトが有効になること" do
    invalid_circumstances = %w(comit chllnge)
    invalid_circumstances.each do |invalid_circumstance|
      habit_form.circumstance = invalid_circumstance
      habit_form.valid?
      expect(habit_form).to be_invalid
    end
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
  it "無効なパターンを「効果」に入力すると、フォームオブジェクトが無効になること" do
    invalid_effects = ["1, 2", "1, ", "1, -"]
    invalid_effects.each do |invalid_effect|
      habit_form.effects = invalid_effect
      habit_form.valid?
      expect(habit_form).to be_invalid
    end
  end
  it "有効なパターンを「効果」に入力すると、フォームオブジェクトが有効になること" do
    valid_effects = ["1", "1,a", "1,a,A", "1,a,A,あ", "1,a,A,あ,亜"]
    valid_effects.each do |valid_effect|
      habit_form.effects = valid_effect
      habit_form.valid?
      expect(habit_form).to be_valid
    end
  end

  # 参考資料
  it "無効なURLが入力されたら、フォームオブジェクトが無効になること" do
    invalid_urls = %w(
    "http://www.example.com/space%20here.html", 
    "ftp://www.example.com/",
    "http://www.example.com/and%26here.html",
    )
    habit_form.urls = invalid_urls
    habit_form.valid?
    expect(habit_form).to be_invalid
  end
  it "無効なURLが入力されたら、フォームオブジェクトが無効になること" do
    valid_urls = %w(
    "http://www.example.com/", 
    "https://www.example.com/",
    )
    habit_form.urls = valid_urls
    habit_form.valid?
    expect(habit_form).to be_valid
  end
end
