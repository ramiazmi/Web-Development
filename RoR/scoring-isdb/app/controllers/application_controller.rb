class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_me!, if: :devise_controller?
  before_action :authenticate_user!, :except => [:home_index]
  before_action :configure_permitted_parameters_reg, if: :devise_controller?

  protected

def authenticate_me!
    # authenticate_user!
    if controller_name=="registrations" and action_name=="index" and !(user_signed_in?)
      redirect_to '/users/sign_in', alert: t("devise.failure.unauthenticated")
      # alert: "You need to sign in or sign up before continuing."
    end
end

  def configure_permitted_parameters_reg
    # devise_parameter_sanitizer.for(:sign_up)  { |u| u.permit(:user_name, :email, :password, :confirmed_at, :user_type) }
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name, :email, :password, :confirmed_at, :user_type])
  end
end
