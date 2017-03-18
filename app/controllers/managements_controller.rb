class ManagementsController < ApplicationController
  before_action :authenticate_user!, :set_management, only: [:show, :edit, :update, :destroy]
  before_filter :setup_friends, :setup_subscription, :setup_cards, :setup_events, :setup_invite_form, :setup_user_network_activities

  def index
    #@managements = Management.order("monthyear desc")
    @managements = Management.order("date desc")
  end

  def show
  end

  def new
    @management = Management.new
  end

  def edit
  end

  def create
    @management = Management.new(management_params)

    respond_to do |format|
      if @management.save
        format.html { redirect_to @management, notice: 'Management was successfully created.' }
        format.json { render :show, status: :created, location: @management }
      else
        format.html { render :new }
        format.json { render json: @management.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @management.update(management_params)
        format.html { redirect_to @management, notice: 'Management was successfully updated.' }
        format.json { render :show, status: :ok, location: @management }
      else
        format.html { render :edit }
        format.json { render json: @management.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @management.destroy
    respond_to do |format|
      format.html { redirect_to managements_url, notice: 'Management was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def details  
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

  def set_management
    @management = Management.find(params[:id])
  end

  def management_params
    params.require(:management).permit(:venuecost, :hostcost, :date, :event_id, :monthyear, :week)
  end
end
