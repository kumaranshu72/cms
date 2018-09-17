class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :email, :password, :current_password])
  end
end
