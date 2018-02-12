class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]
  before_filter :setup_friends, :setup_subscription, :setup_cards, :setup_invite_form, :setup_user_network_activities

  def index
    @albums = Album.all
  end

  def show
  end

  def new
    if current_user.admin_pa_management_group || current_user.pa_event_mgt_group
      @album = Album.new
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
      @album = Album.new(album_params)

      respond_to do |format|
        if @album.save
          format.html { redirect_to stats_albums_user_path(current_user), notice: 'Album was successfully created.' }
          format.json { render :show, status: :created, location: @album }
        else
          format.html { render :new }
          format.json { render json: @album.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    if current_user.admin_pa_management_group || current_user.pa_event_mgt_group
      respond_to do |format|
        if @album.update(album_params)
          format.html { redirect_to stats_albums_user_path(current_user), notice: 'Album was successfully updated.' }
          format.json { render :show, status: :ok, location: @album }
        else
          format.html { render :edit }
          format.json { render json: @album.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to errorpermission_path
    end
  end

  def destroy
    if current_user.admin_pa_management_group 
      @album.destroy
      respond_to do |format|
        format.html { redirect_to stats_albums_user_url(current_user), notice: 'Album was successfully destroyed.' }
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

    def set_album
      @album = Album.find(params[:id])
    end

    def album_params
      params.require(:album).permit(:name, :date, :description, :image, :publish, :album_image_link, :user_id)
    end
end
