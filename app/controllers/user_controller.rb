class UserController < ApplicationController
  def show
    @user = current_user
  end

  def log_in_guest
    @user = User.find_by(name: "guest")
    if @user.present?
      sign_in(@user)
    end
    flash[:notice] = "Welcome! You have signed up successfully."
    redirect_to root_path
  end
end
