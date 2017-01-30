class FavouriteSocialsController < ApplicationController
  before_action :authenticate_user!, :set_social
  
  def create
    if Favourite.find_or_create_by(favourited: @social, user: current_user)
      redirect_to :back, notice: 'Social has been Saved'
    else
      redirect_to :back, alert: 'Something went wrong...*sad panda*'
    end
  end
  
  def destroy
    Favourite.where(favourited_id: @social.id, user_id: current_user.id).first.destroy
    redirect_to :back, notice: 'Social has been removed from Saved List'
  end
  
  private
  def set_social
    @social = Social.friendly.find(params[:social_id] || params[:id])
  end
end


