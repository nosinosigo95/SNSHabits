require 'rails_helper'

RSpec.describe "header", type: :system do
  before do
    visit root_url
  end
  it "Homeや習慣、日記、交流のリンクが表示されていること" do
    expect(page).to have_link 'Home'
    expect(page).to have_link '習慣'
    expect(page).to have_link '日記'
    expect(page).to have_link '交流'
  end
  it "ユーザーがログイン状態でないならば、ユーザー登録とログイン、ゲストログインのリンクが表示されていること" do
    expect(page).to have_link 'ユーザー登録'
    expect(page).to have_link 'ログイン'
    expect(page).to have_link 'ゲストログイン'
  end
  it "ユーザーがログイン状態であるならば、アカウントとログアウトのリンクが表示されていること" do
    user = FactoryBot.create(:user)
    visit new_user_session_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_on 'Log in'
    expect(page).to have_link 'アカウント'
    expect(page).to have_link 'ログアウト'
  end
end
