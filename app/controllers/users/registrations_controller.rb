class Users::RegistrationsController < Devise::RegistrationsController

  def create
    @user = User.find(params[:id])
    MailerWelcomemember.welcome_member(@user).deliver
  end

  protected
    def after_update_path_for(resource)
      settings_user_path(resource)
    end
end

