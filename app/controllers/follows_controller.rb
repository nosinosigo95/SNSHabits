class FollowsController < ApplicationController

  def create
    followed_user = User.find(params[:user_id])
    current_user.follow(followed_user)
    redirect_to request.referer
  end

  def destory
    followed_user = User.find(params[:user_id])
    current_user.unfollow(followed_user)
    redirect_to request.referer
  end

  def followings
    @user = User.find(params[:user_id])
    @users = user.followings
  end

  def followers
    @ser = User.find(params[:user_id])
    @users = user.follower
  end
end
