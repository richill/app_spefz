class UsersController < ApplicationController
  respond_to :html, :xml, :json
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
    respond_with(@user)
  end

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to @user
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :firstname, :lastname, :birthdate, :category_gender_id)
    end
end
