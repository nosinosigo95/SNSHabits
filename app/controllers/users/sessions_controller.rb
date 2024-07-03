# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for(resource)
    habits_url(habit_index_form: { created: '1' })
  end
end
