class UsersController < ApplicationController
  before_action :authenticate_user!
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
    @followings = @user.followings
    if @followings.empty?
      flash[:searched_result] = "フォローされているユーザーはいません"
    end
    redirect_to request.referer
  end

  def followers
    @user = User.find(params[:user_id])
    @followers = @user.followers
    if @followers.empty?
      flash[:searched_result] = "フォローしているユーザーはいません"
    end
    redirect_to request.referer
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
end
