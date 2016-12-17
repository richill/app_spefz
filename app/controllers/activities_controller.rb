class ActivitiesController < ApplicationController
  before_filter :setup_friends
  
  def index
    @activities = PublicActivity::Activity.order("created_at desc")
  end

  def networks 
    @activities = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user)
  end


  private
    def setup_friends
      @user = User.find(current_user.id)
      @friend = User.find_by_email(params[:id])
    end
end
