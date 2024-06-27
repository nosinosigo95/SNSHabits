# frozen_string_literal: true
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

  describe '日記作成ページ' do
    it "すべての項目を入力すれば、日記が作成されること" do
      habit = FactoryBot.create(:habit, user: user)
      visit new_diary_path(habit.id)
      fill_in '実行日', with: '2024/6/24'
      fill_in '自由記述(600字以内)', with: '自由'
      fill_in '実行時間(時:分)', with: '01:00'
      choose 'はい'
      click_on '記録する'
      expect(page).to have_content("日記を作成しました")
    end
  end

  describe '日記編集ページ' do
    it "すべての項目を入力すれば、日記が更新されること" do
      habit = FactoryBot.create(:habit, user: user)
      diary = FactoryBot.create(:diary, user: user, habit: habit)
      visit edit_diary_path(diary.id)
      fill_in '実行日', with: '2024/6/24'
      fill_in '自由記述(600字以内)', with: '自由'
      fill_in '実行時間(時:分)', with: '01:00'
      choose 'はい'
      click_on '記録する'
      expect(page).to have_content("日記を更新しました")
    end
  end
end
