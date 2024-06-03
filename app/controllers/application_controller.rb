class ApplicationController < ActionController::Base
  protected
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :icon])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :icon])
end
