class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  helper_method :message, :conversation

  def after_sign_up_path_for(resources)
    # user_path(current_user)
    events_path
  end
  
  def after_sign_in_path_for(resources)
    # user_path(current_user)
    events_path
  end

  def after_sign_out_path_for(resources)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:email) }
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :firstname, :lastname, :birthdate, :category_gender_id, :category_country_id) }
  end

  private
  def message
    @message ||= current_user.mailbox
  end

  def conversation
    @conversation ||= message.conversations.find(params[:id])
  end
end



