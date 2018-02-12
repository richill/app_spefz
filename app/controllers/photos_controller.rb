class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_filter :setup_friends, :setup_subscription, :setup_cards, :setup_invite_form, :setup_user_network_activities

  def index
    @photos = Photo.all
  end

  def show
    unless current_user.admin_pa_management_group
      redirect_to errorpermission_path
    end
  end

  def new
    if current_user.admin_pa_management_group || current_user.pa_event_mgt_group
      @photo = Photo.new
    else
      redirect_to errorpermission_path
    end
  end

  def edit
    unless current_user.admin_pa_management_group || current_user.pa_event_mgt_group
      redirect_to errorpermission_path
    end
  end

  def create
    if current_user.admin_pa_management_group || current_user.pa_event_mgt_group
      @photo = Photo.new(photo_params)

      respond_to do |format|
        if @photo.save
          format.html { redirect_to stats_photos_user_path(current_user), notice: 'Photo was successfully created.' }
          format.json { render :show, status: :created, location: @photo }
        else
          format.html { render :new }
          format.json { render json: @photo.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to errorpermission_path
    end
  end

  def update
    if current_user.admin_pa_management_group || current_user.pa_event_mgt_group
      respond_to do |format|
        if @photo.update(photo_params)
          format.html { redirect_to stats_photos_user_path(current_user), notice: 'Photo was successfully updated.' }
          format.json { render :show, status: :ok, location: @photo }
        else
          format.html { render :edit }
          format.json { render json: @photo.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to errorpermission_path
    end
  end

  def destroy
    if current_user.admin_pa_management_group 
      @photo.destroy
      respond_to do |format|
        format.html { redirect_to stats_photos_user_url(current_user), notice: 'Photo was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to errorpermission_path
    end
  end

  private
    def setup_friends
      if signed_in?
        @user = User.find(current_user.id)
        @friend = User.find_by_email(params[:id])
      end
    end

    def setup_subscription
      if signed_in?
        @premium_plan = Subscription.find_by(title:"premium") 
      end
    end

    def setup_cards
      if signed_in?
        @cards = Card.all
      end
    end

    def setup_invite_form
      if signed_in?
        @invite = Invite.new
      end
    end

    def setup_user_network_activities
      if signed_in?
        @user_network_activities = Activity.order("created_at desc").where(owner_id: current_user.friends)
        @activity =  Activity.last
      end
    end

    def set_photo
      @photo = Photo.find(params[:id])
    end

    def photo_params
      params.require(:photo).permit(:name, :description, :image, :publish, :photo_image_link, :album_id)
    end
end
