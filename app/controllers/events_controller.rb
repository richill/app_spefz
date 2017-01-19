class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_filter :setup_friends, :setup_subscription, :setup_cards, :setup_invite_form, :setup_user_network_activities

  def index
    if params[:tag]
      @events = Event.events_access_below_user_score(current_user).tagged_with(params[:tag]).live_events.open_events
      @search = Event.search(params[:q])
      @listed_events = @search.result(distinct: true)
    else
      @search = Event.events_access_below_user_score(current_user).search(params[:q])
      @events = @search.result(distinct: true).live_events.open_events
    end
    @report = Report.new
  end

  def show
    @host = Host.new
    @card = Card.new
    unless @event.event_access_below_user_score(current_user)
      redirect_to errorpermission_path
      #directs user to access_restricted page if event_access_score is > user average rating
    end
  end

  def new
    if current_user.admin_pa_management_group || current_user.pa_event_mgt_group
      @premium_plan = Subscription.find_by(title:"premium")
      @user = User.friendly.find(params[:user_id])
      @event = @user.events.build
    else
      redirect_to errorpermission_path
    end
  end

  def edit
    if current_user.admin_pa_management_group || current_user.pa_event_mgt_group
      @premium_plan = Subscription.find_by(title:"premium")
      @user = User.friendly.find(params[:user_id])
    else
      redirect_to errorpermission_path
    end
  end

  def create
    if current_user.admin_pa_management_group || current_user.pa_event_mgt_group
      @premium_plan = Subscription.find_by(title:"premium")
      @user = User.friendly.find(params[:user_id])
      @event = @user.events.create(event_params)

      respond_to do |format|
        if @event.save
          format.html { redirect_to([@event.user, @event], notice: 'Speed Event was successfully created.') }
          format.json  { render json: @event, status: :created, location: @event }
        else
          format.html { render action: "new" }
          format.json  { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to errorpermission_path
    end
  end

  def update
    if current_user.admin_pa_management_group || current_user.pa_event_mgt_group
      respond_to do |format|
        if @event.update_attributes(event_params)
          format.html { redirect_to([@event.user, @event], notice: 'Speed Event was successfully updated.') }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to errorpermission_path
    end
  end

  def destroy
    if current_user.admin_pa_management_group
      @premium_plan = Subscription.find_by(title:"premium")
      @user = User.friendly.find(params[:user_id])
      @event = Event.friendly.find(params[:id])
      @event.destroy
      redirect_to events_path
    else
      redirect_to errorpermission_path
    end
  end

  def attendants
    if current_user.admin_pa_management_group || current_user.pa_event_mgt_group 
      @event = Event.friendly.find(params[:id])
      @premium_plan = Subscription.find_by(title:"premium")
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

  def setup_invite_form
    @invite = Invite.new
  end

  def setup_user_network_activities
    @user_network_activities = Activity.order("created_at desc").where(owner_id: current_user.friends)
  end

  def set_event
    @event = Event.friendly.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :address, :postcode, :latitude, :longitude, :user_id, :category_topic_id, :image, :date, :time, :city, :quantity, :category_age_id, :category_country_id, :quantity_men, :quantity_women, :category_quantitygender_id, :venuename, :price, :time_end, :tag_list, :maplink, :close, :slug, :event_score_access)
  end
end
