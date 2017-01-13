class ActivitiesController < ApplicationController
  before_filter :setup_friends, :setup_subscription, :setup_cards, :setup_events, :setup_invite_form, :setup_user_network_activities

  def index
    @activities = Activity.order("created_at desc").where("trackable_type IN (?)", ["Social", "Event"]) 
  end

  def networks 
    @activities = Activity.order("created_at desc").where(owner_id: current_user.friends)
  end

  def followings 
    @activities = Activity.order("created_at desc").where(owner_id: current_user.followings)
  end

  def mark_as_viewed
    @activity =  Activity.find(params[:activity_id]) 
    @activity.mark_as_read! :for => current_user
    redirect_to :back
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

  def setup_user_network_activities
    @user_network_activities = Activity.order("created_at desc").where(owner_id: current_user.friends)
  end

  def setup_invite_form
    @invite = Invite.new
  end
end
