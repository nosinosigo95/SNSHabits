class FollowsController < ApplicationController

  def create
    followed_user = User.find(params[:id])
    current_user.follow(followed_user)
  end

  def destory
    followed_user = User.find(params[:id])
    current_user.unfollow(followed_user)
  end

  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.follower
  end
end
