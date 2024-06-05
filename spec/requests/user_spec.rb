require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user){FactoryBot.create(:user, introduction: "text text")}
  let(:image_name){ "person-circle.svg" }
  before do
    sign_in user
  end

  describe "アカウントページ(/user/show)" do
    it "正常にアカウントページにアクセスできること" do
      get user_show_path
      expect(response).to have_http_status(:success)
    end
    it "ユーザーの名前がレスポンスにあること" do
      get user_show_path
      expect(response.body).to include(user.name)
    end
    it "ユーザーのメールアドレスがレスポンスにあること" do
      get user_show_path
      expect(response.body).to include(user.email)
    end
    it "ユーザーの自己紹介がレスポンスにあること" do
      get user_show_path
      expect(response.body).to include(user.introduction)
    end
    it "ユーザーのアイコンがレスポンスにあること" do
      get user_show_path
      expect(response.body).to include(image_name)
    end
  end

  describe "アカウント編集ページ(/users/edit)" do
    it "正常にアカウント編集ページにアクセスできること" do
      get edit_user_registration_path
      expect(response).to have_http_status(:success)
    end
    it "ユーザーの名前がレスポンスにあること" do
      get edit_user_registration_path
      expect(response.body).to include(user.name)
    end
    it "ユーザーのメールアドレスがレスポンスにあること" do
      get edit_user_registration_path
      expect(response.body).to include(user.email)
    end
    it "ユーザーの自己紹介がレスポンスにあること" do
      get edit_user_registration_path
      expect(response.body).to include(user.introduction)
    end
  end
end
