class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy]
  before_filter :setup_subscription

  # user = event
  # blog = card

  def index
    @cards = Card.all
  end

  def show
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
    @card = @event.cards.create(card_params)

    respond_to do |format|
      if @card.save
        format.html { redirect_to([@card.event, @card], notice: 'Card was successfully created.') }
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

  private
    def set_card
      @card = Card.find(params[:id])
    end

    def setup_subscription
      @premium_plan = Subscription.find_by(title:"premium") 
    end

    def card_params
      params.require(:card).permit(:title, :event_id)
    end
end
