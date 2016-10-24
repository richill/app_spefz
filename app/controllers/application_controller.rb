class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  helper_method :messages

  def after_sign_up_path_for(resources)
    socials_path
  end
  
  def after_sign_in_path_for(resources)
    socials_path
  end

  def after_sign_out_path_for(resources)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email) }
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :firstname, :lastname, :birthdate, :password, :category_gender_id) }
  end


  private

  def messages
    @messages ||= current_user.messages
  end

  # def mailbox
  #   @mailbox ||= current_user.mailbox
  # end
end
