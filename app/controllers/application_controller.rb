class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_featured
  helper_method :is_admin!
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end

  def set_featured
    @featured = Genre.where(feature_in_navbar: true).order('name ASC')
  end

  def is_admin!
    unless current_user&.admin
      redirect_to root_path
    end
  end

end
