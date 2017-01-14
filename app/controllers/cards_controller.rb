class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy]
  before_filter :setup_friends, :setup_subscription, :setup_cards, :setup_events, :setup_invite_form, :setup_user_network_activities

  def index
    @cards = Card.all
  end

  def show
    @logged_in_user = current_user if signed_in?
    @friend = User.find_by_email(params[:id])
    # @friend = User.find(params[:user_id])
  end

  def new
    @event = Event.friendly.find(params[:event_id])
    @card = @event.cards.build
  end

  def edit
    @event = Event.friendly.find(params[:event_id])
  end

  def create
    @event = Event.friendly.find(params[:event_id])
    @event.card = Card.new(card_params)
    @card = @event.card
    respond_to do |format|
      if @card.save
        # format.html { redirect_to([@card.event, @card], notice: 'Card was successfully created.') }
        format.html { redirect_to :back, notice: 'Card was successfully created.' }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to([@card.event, @card], notice: 'Card was successfully updated.') }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event = Event.friendly.find(params[:event_id])
    @card = @event.cards.find(params[:id])
    @card.destroy
    respond_to do |format|
      format.html { redirect_to cards_url, notice: 'Card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def mark_as_viewed
    @card =  Card.find(params[:card_id]) 
    @card.mark_as_read! :for => current_user
    redirect_to @card
  end

  private
  def setup_friends
    @user = User.find(current_user.id)
    # @user = User.friendly.find(params[:id])
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
  end

  def set_card
    @card = Card.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:title, :event_id, :status)
  end
end
