require 'rails_helper'

RSpec.describe "Habits", type: :system do
  let(:user){ FactoryBot.create(:user) }

  before do
    sign_in(user)
  end

  describe "検索ページ" do
    before do
      @habit_index = HabitIndexForm.new
      FactoryBot.create_list(:habit, 10)
      visit habits_url
    end
    it "検索フォームが表示されていること" do
      within '.search-form' do
        expect(page).to have_content('習慣名')
        expect(page).to have_content('効果')
        expect(page).to have_content('効果が出始める頃')
        expect(page).to have_content('自身が作成したもの')
      end
    end
    it "検索フォームに最近作成されたものを選択すると、その習慣が表示されること" do
      habits = FactoryBot.create_list(:habit, 10)
      select "最近作成されたもの", from: "habit_index_form_sort"
      click_on '検索'
      habits.each do |habit|
        if habit.commit
          expect(page).to have_content(habit.name)
        end
      end
    end
    it "検索フォームに習慣名を入力すると、その習慣が表示されること" do
      habit = FactoryBot.create(:habit, name:"sample")
      fill_in "習慣名", with: "sample"
      select "最近作成されたもの", from: "habit_index_form_sort"
      click_on '検索'
      expect(page).to have_content("sample")
    end
  end
  describe '習慣作成ページ' do
    before do
      visit new_habit_url
    end
    it '習慣名と効果、概要、説明・工夫、状況を入力すれば、登録が完了すること' do
      fill_in '習慣名', with: "habit"
      fill_in '効果(キーワード5つ以内)', with: '効果'
      fill_in '概要', with: '概要'
      fill_in '説明・工夫', with: 'sample sample'
      choose '挑戦中'
      click_on '保存する'

      expect(page).to have_content('習慣を作成しました')
    end
  end
  describe '習慣編集ページ' do
    it '習慣名と効果、概要、説明・工夫、状況を入力すれば、登録が更新すること' do
      visit new_habit_url
      fill_in '習慣名', with: "habit"
      fill_in '効果(キーワード5つ以内)', with: '効果'
      fill_in '概要', with: '概要'
      fill_in '説明・工夫', with: 'sample sample'
      choose '挑戦中'
      click_on '保存する'
      within '.habit-display' do
        click_on '編集'
      end
      fill_in '習慣名', with: "habit"
      fill_in '効果(キーワード5つ以内)', with: '効果'
      fill_in '概要', with: '概要'
      fill_in '説明・工夫', with: 'sample sample'
      choose '挑戦中'
      click_on '保存する'
      expect(page).to have_content('習慣を更新しました')
    end
  end
  describe '習慣詳細ページ' do
    it 'お気に入りをクリックすると、習慣はお気に入りになること' do
      visit new_habit_url
      fill_in '習慣名', with: "habit"
      fill_in '効果(キーワード5つ以内)', with: '効果'
      fill_in '概要', with: '概要'
      fill_in '説明・工夫', with: 'sample sample'
      choose '挑戦中'
      click_on '保存する'

      click_on 'お気に入り'
      expect(page).to have_content('お気に入りに入れました')
    end
  end
end
