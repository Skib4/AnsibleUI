class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  add_flash_types :success, :warning, :danger, :info

  protected


    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :name, :surname, :approved, :admin])
      devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password, :password_confirmation, :name, :surname, :approved, :admin])
      devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :name, :surname, :approved, :admin])
    end

end
