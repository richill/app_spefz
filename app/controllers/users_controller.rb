class UsersController < ApplicationController
  respond_to :html, :xml, :json
  before_action :set_user, only: [:show, :edit, :update, :destroy]


  def show
    respond_with(@user)
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email)
    end
end
