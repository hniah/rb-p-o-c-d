class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def home
    @sliders = Slider.all
    @latest_update_blocks = LatestUpdate.all.order('created_at DESC').take(3)
    render :home
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      rails_admin_path
    else
      user_info_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:name, :address, :unit, :postal,:contact_number,:alternative_contact_number, :instruction, :terms_of_service, :subscribe_to_mailing_list, :how_did_you_hear_about_us]
    devise_parameter_sanitizer.for(:account_update) << [:name, :address, :unit, :postal, :contact_number,:alternative_contact_number, :instruction, :avatar]
  end
end
