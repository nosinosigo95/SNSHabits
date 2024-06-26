require 'rails_helper'

RSpec.describe "Diaries", type: :system do
  let(:user) { FactoryBot.create(:user) }
  before do
    sign_in(user)
  end
  describe '日記一覧ページ' do
    it '作成した日記がページに表示されていること' do
      diaries = FactoryBot.create_list(:diary, 10, user: user)
      visit diaries_path
      diaries.each do |diary|
        expect(page).to have_content(diary.description)
      end
    end
  end
end
