class BusinessadsController < ApplicationController
  before_action :set_businessad, only: [:show, :edit, :update, :destroy]
  before_filter :setup_friends, :setup_subscription, :setup_cards, :setup_events, :setup_invite_form, :setup_user_network_activities

  def index
    if current_user.admin_pa_management_group || current_user.pa_event_mgt_group
      @businessads = Businessad.all
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
      @businessad = Businessad.new
    else
      redirect_to errorpermission_path
    end
  end

  def edit
  end

  def create
    @businessad = Businessad.new(businessad_params)

    respond_to do |format|
      if @businessad.save
        format.html { redirect_to @businessad, notice: 'Businessad was successfully created.' }
        format.json { render :show, status: :created, location: @businessad }
      else
        format.html { render :new }
        format.json { render json: @businessad.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @businessad.update(businessad_params)
        format.html { redirect_to @businessad, notice: 'Businessad was successfully updated.' }
        format.json { render :show, status: :ok, location: @businessad }
      else
        format.html { render :edit }
        format.json { render json: @businessad.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @businessad.destroy
    respond_to do |format|
      format.html { redirect_to businessads_url, notice: 'Businessad was successfully destroyed.' }
      format.json { head :no_content }
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
    @premium_plan = Subscription.find_by(title:"premium") 
  end

  def setup_cards
    @cards = Card.all
  end

  def setup_events
    @events = Event.all
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

  def set_businessad
    @businessad = Businessad.find(params[:id])
  end

  def businessad_params
    params.require(:businessad).permit(:name, :content, :link, :image, :displaytext, :category_advert_id, :event_id)
  end
end
