class SubscriptionsController < ApplicationController
  before_action :authenticate_user!, :set_subscription, only: [:show, :edit, :update, :destroy]
  before_filter :setup_friends, :setup_subscription, :setup_cards, :setup_events, :setup_invite_form, :setup_user_network_activities

  # GET /subscriptions
  # GET /subscriptions.json
  def index
    if current_user.admin_pa_management_group
      @subscriptions = Subscription.all
    else
      redirect_to errorpermission_path
    end
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
    if current_user == @user
      @premium_plan = Subscription.find_by(title:"premium")
    else
      redirect_to errorpermission_path
    end
  end

  # GET /subscriptions/new
  def new
    if current_user.admin_pa_management_group
      @subscription = Subscription.new
    else
      redirect_to errorpermission_path
    end
  end

  # GET /subscriptions/1/edit
  def edit
    unless current_user.admin_pa_management_group
      redirect_to errorpermission_path
    end
  end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    if current_user.admin_pa_management_group
      @subscription = Subscription.new(subscription_params)
      respond_to do |format|
        if @subscription.save
          format.html { redirect_to @subscription, notice: 'Subscription was successfully created.' }
          format.json { render :show, status: :created, location: @subscription }
        else
          format.html { render :new }
          format.json { render json: @subscription.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to errorpermission_path
    end
  end

  # PATCH/PUT /subscriptions/1
  # PATCH/PUT /subscriptions/1.json
  def update
    if current_user.admin_pa_management_group
      respond_to do |format|
        if @subscription.update(subscription_params)
          format.html { redirect_to @subscription, notice: 'Subscription was successfully updated.' }
          format.json { render :show, status: :ok, location: @subscription }
        else
          format.html { render :edit }
          format.json { render json: @subscription.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to errorpermission_path
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    if current_user.admin_pa_management_group
      @subscription.destroy
      respond_to do |format|
        format.html { redirect_to subscriptions_url, notice: 'Subscription was successfully destroyed.' }
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
  
  # Use callbacks to share common setup or constraints between actions.
  def set_subscription
    @subscription = Subscription.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def subscription_params
    params.require(:subscription).permit(:title, :price)
  end
end
