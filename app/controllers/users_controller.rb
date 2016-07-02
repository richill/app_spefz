class UsersController < ApplicationController
  respond_to :html, :xml, :json
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :user_not_allowed_to_view, only: [:show]

  def show
    respond_with(@user)
  end

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to @user
  end

  def user_not_allowed_to_view
    redirect_to root_path
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :firstname, :lastname, :birthdate, :category_gender_id)
    end
end
