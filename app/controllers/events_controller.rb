class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    if params[:tag]
      @events = Event.tagged_with(params[:tag])
      @search = Event.search(params[:q])
      @listed_events = @search.result(distinct: true)
    else
      @search = Event.search(params[:q])
      @events = @search.result(distinct: true)
    end
    @premium_plan = Subscription.find_by(title:"premium")
  end

  def show
  end

  def new
    # @event = Event.new
    @user = User.find(params[:user_id])
    @event = @user.events.build
  end

  def edit
    @user = User.find(params[:user_id])
  end

  def create
    @user = User.find(params[:user_id])
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
  end

  def update
    respond_to do |format|
      if @event.update_attributes(event_params)
        format.html { redirect_to([@event.user, @event], notice: 'Speed Event was successfully updated.') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @event = @user.events.find(params[:id])
    @event.destroy
    redirect_to events_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :description, :address, :postcode, :latitude, :longitude, :user_id, :category_topic_id, :image, :date, :time, :city, :quantity, :category_age_id, :category_country_id, :quantity_men, :quantity_women, :category_quantitygender_id, :venuename, :price, :time_end, :tag_list, :maplink)
    end
end
