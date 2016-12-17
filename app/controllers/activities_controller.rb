class ActivitiesController < ApplicationController
  before_filter :setup_friends, :setup_subscription

  def index
    @activities = PublicActivity::Activity.order("created_at desc")
  end

  def networks 
    @activities = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.friends)
  end

  def followings 
    @activities = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.followings)
  end

  private
    def setup_friends
      @user = User.find(current_user.id)
      @friend = User.find_by_email(params[:id])
    end

    def setup_subscription
      @premium_plan = Subscription.find_by(title:"premium") 
    end
end
