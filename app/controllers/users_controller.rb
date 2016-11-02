class UsersController < ApplicationController
  respond_to :html, :xml, :json
  before_action :set_user, only: [:show, :edit, :update, :destroy, :followings, :followers]

  def index
    if params[:tag]
      @users = User.tagged_with(params[:tag])
    else
      @users = User.all
    end
  end

  def show
    @events = Event.all
  end

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to @user
  end

  def dashboard
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :firstname, :lastname, :birthdate, :category_gender_id, :description, :profession, :image, :tag_list, :category_role_id, :category_managementgroup_id)
    end
end
