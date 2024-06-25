class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:log_in_guest]
  def create
    followed_user = User.find(params[:user_id])
    current_user.follow(followed_user)
    redirect_to request.referer
  end

  def destroy
    followed_user = User.find(params[:user_id])
    current_user.unfollow(followed_user)
    redirect_to request.referer
  end

  def followings
    @user = User.includes(:followings).find(params[:user_id])
    @followings = @user.followings.includes(:icon_attachment).page(params[:page])
  end

  def followers
    @user = User.includes(:followings).find(params[:user_id])
    @followers = @user.followers.includes(:icon_attachment).page(params[:page])
  end

  def index
    if params[:search].nil?
      @users = User.includes(:icon_attachment).all.page(params[:page])
    else
      @users = User.includes(:icon_attachment).where('name like ?', params[:search][:name] + '%').page(params[:page])
      if @users.empty?
        @users = User.includes(:icon_attachment).all.page(params[:page])
        flash[:notice] = "ユーザーを見つけられませんでした.
        "
      end
    end
  end

  def show
    @user = User.includes(:diaries).find(params[:id])
    @diaries = @user.diaries.includes(:habit).page(params[:page])
  end

  def log_in_guest
    @user = User.find_by(name: "guest")
    if @user.present?
      sign_in(@user)
      flash[:notice] = "ようこそ！あなたはログインに成功しました。"
    end
    redirect_to root_path
  end
end
