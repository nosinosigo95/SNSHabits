class FollowsController < ApplicationController
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
    @users = @user.followings
  end

  def followers
    @user = User.find(params[:user_id])
    @users = @user.follower
  end
end
