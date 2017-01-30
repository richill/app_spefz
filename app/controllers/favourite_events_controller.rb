class FavouriteEventsController < ApplicationController
  before_action :authenticate_user!, :set_event
  
  def create
    if Favourite.find_or_create_by(favourited: @event, user: current_user)
      redirect_to :back, notice: 'Event has been Saved'
    else
      redirect_to :back, alert: 'Something went wrong...*sad panda*'
    end
  end
  
  def destroy
    Favourite.where(favourited_id: @event.id, user_id: current_user.id).first.destroy
    redirect_to :back, notice: 'Event has been removed from Saved List'
  end
  
  private
  def set_event
    @event = Event.friendly.find(params[:event_id] || params[:id])
  end
end


