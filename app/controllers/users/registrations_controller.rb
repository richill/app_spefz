class Users::RegistrationsController < Devise::RegistrationsController

  protected
    def after_update_path_for(resource)
      settings_user_path(resource)
    end
end

