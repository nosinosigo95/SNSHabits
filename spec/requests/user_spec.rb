require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user){FactoryBot.create(:user)}
  
  before do
    sign_in user
    get "/user/show"
  end

  describe "アカウントページ(/user/show)" do
    it "正常にアカウントページにアクセスできること" do
      expect(response).to have_http_status(:success)
    end
    it "ユーザーの名前がレスポンスにあること" do
      expect(response.body).to include(user.name)
    end
    it "ユーザーのメールアドレスがレスポンスにあること" do
      expect(response.body).to include(user.email)
    end
  end
end
