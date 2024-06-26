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
end
