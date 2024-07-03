# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  protected

  def after_sign_up_path_for(resource)
    habits_url
  end

  def after_update_path_for(resource)
    user_url(current_user.id)
  end
end
