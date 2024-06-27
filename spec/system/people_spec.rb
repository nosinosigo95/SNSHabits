require 'rails_helper'

RSpec.describe "People", type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in(user)
  end

  describe 'ユーザー検索ページ' do
    before do
      visit people_path
    end
    it "ユーザー検索フォームが表示されていること" do
      within 'form' do
        expect(page).to have_content('ユーザー名')
      end
    end
    it "ユーザーを検索すれば、そのユーザーが表示されること" do
      user = FactoryBot.create(:user, name: 'sample')
      fill_in 'ユーザー名', with: 'sample'
      click_on '検索する'
      expect(current_path).to eq people_path
      expect(page).to have_content(user.name)
    end
  end

  describe 'ユーザー詳細ページ' do
    before do
      visit people_path
    end
    it "indexページでユーザー名をクリックしたら、そのユーザーの詳細ページが表示されること" do
      user = FactoryBot.create(:user, name: 'example')
      fill_in 'ユーザー名', with: 'example'
      click_on '検索する'
      click_on 'example'
      expect(current_path).to eq user_path(user.id)
    end
  end
end
