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
    @user = User.find(params[:user_id])
    @followings = @user.followings.page(params[:page])

  end

  def followers
    @user = User.find(params[:user_id])
    @followers = @user.followers.page(params[:page])
  end

  def index
    if params[:search].nil?
      @users = User.all.page(params[:page])
    else
      @users = User.where('name = ?', params[:search][:name]).page(params[:page])
      if @users.empty?
        @users = User.all.page(params[:page])
        flash[:notice] = "ユーザーを見つけられませんでした"
      end
    end
  end

  def show
    @user = User.find(params[:id])
    @diaries = @user.diaries.page(params[:page])
  end

  def log_in_guest
    @user = User.find_by(name: "guest")
    if @user.present?
      sign_in(@user)
    end
    # ログイン後に処理する
    flash[:notice] = "Welcome! You have signed up successfully."
    redirect_to root_path
  end
end
