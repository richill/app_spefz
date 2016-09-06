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


  # GET /users/1
  # GET /users/1.json
  def show
    @events = Event.all
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user.update(user_params)
    redirect_to @user
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :firstname, :lastname, :birthdate, :category_gender_id, :description, :profession, :image, :tag_list)
    end
end
