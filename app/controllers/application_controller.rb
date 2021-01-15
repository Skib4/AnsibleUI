class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  add_flash_types :success, :warning, :danger, :info
  before_action :set_locale

  protected


    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :name, :surname, :approved, :admin])
      devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password, :password_confirmation, :name, :surname, :approved, :admin])
      devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :name, :surname, :approved, :admin])
    end

    def set_locale
      I18n.locale = session[:locale] || I18n.default_locale
    end
end
