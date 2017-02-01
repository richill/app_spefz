class VenuesController < ApplicationController
  before_action :authenticate_user!, :set_venue, only: [:show, :edit, :update, :destroy]
  before_filter :setup_friends, :setup_subscription, :setup_cards, :setup_events, :setup_invite_form, :setup_user_network_activities

  def index
    if current_user.admin_pa_management_group || current_user.pa_event_mgt_group
      @venues = Venue.all
    else
      redirect_to errorpermission_path
    end
  end

  def show
    unless current_user.admin_pa_management_group || current_user.pa_event_mgt_group
      redirect_to errorpermission_path
    end
  end

  def new
    if current_user.admin_pa_management_group || current_user.pa_event_mgt_group
      @venue = Venue.new
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
      @venue = Venue.new(venue_params)
      respond_to do |format|
        if @venue.save
          format.html { redirect_to venues_path, notice: 'Venue was successfully created.' }
          format.json { render :show, status: :created, location: @venue }
        else
          format.html { render :new }
          format.json { render json: @venue.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to errorpermission_path
    end
  end

  def update
    if current_user.admin_pa_management_group || current_user.pa_event_mgt_group
      respond_to do |format|
        if @venue.update(venue_params)
          format.html { redirect_to venues_path, notice: 'Venue was successfully updated.' }
          format.json { render :show, status: :ok, location: @venue }
        else
          format.html { render :edit }
          format.json { render json: @venue.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to errorpermission_path
    end
  end

  def destroy
    if current_user.admin_pa_management_group
      @venue.destroy
      respond_to do |format|
        format.html { redirect_to venues_url, notice: 'Venue was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to errorpermission_path
    end
  end

  private
  def setup_friends
    @user = User.find(current_user.id)
    @friend = User.find_by_email(params[:id])
  end

  def setup_subscription
    @premium_plan = Subscription.find_by(title:"premium") 
  end

  def setup_cards
    @cards = Card.all
  end

  def setup_events
    @events = Event.all
  end

  def setup_invite_form
    @invite = Invite.new
  end

  def setup_user_network_activities
    @user_network_activities = Activity.order("created_at desc").where(owner_id: current_user.friends)
    @activity =  Activity.last
  end

  def set_venue
    @venue = Venue.find(params[:id])
  end

  def venue_params
    params.require(:venue).permit(:venuename, :address, :postcode, :maplink, :station, :price, :min_capacity, :eventmanager, :contact, :image, :website, :category_country_id, :city, :note)
  end
end
