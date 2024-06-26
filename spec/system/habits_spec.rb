require 'rails_helper'

RSpec.describe "Habits", type: :system do
  let(:user){ FactoryBot.create(:user) }
  before do
    sign_in(user)
  end
  describe "検索ページ" do
    before do
      @habit_index = HabitIndexForm.new
      visit habits_url
    end
    it "検索フォームが表示されていること" do
      
    end
    it "検索フォームに入力して、検索結果が表示されていること"
  end
end
