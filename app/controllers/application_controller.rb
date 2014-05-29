class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:name, :address, :unit, :postal,:contact_number,:alternative_contact_number, :instruction, :terms_of_service, :subscribe_to_mailing_list]
    devise_parameter_sanitizer.for(:account_update) << [:name, :unit, :contact_number,:alternative_contact_number, :instruction]
  end
end
