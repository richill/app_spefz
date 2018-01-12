class StaticPagesController < ApplicationController
  # before_filter :user_not_allowed_to_view, only: [:homepg]
  before_filter :setup_subscription, :setup_cards, :setup_events, :setup_invite_form

  def aboutpg
    @premium_plan = Subscription.find_by(title:"premium")
    if signed_in?
      @user_network_activities = Activity.order("created_at desc").where(owner_id: current_user.friends)
      @activity =  Activity.last
      @user = User.find(current_user.id)
      @friend = User.find_by_email(params[:id])
    end
  end

  def accountpg 
    @premium_plan = Subscription.find_by(title:"premium")
    if signed_in?
      @user_network_activities = Activity.order("created_at desc").where(owner_id: current_user.friends)
      @activity =  Activity.last
      @user = User.find(current_user.id)
      @friend = User.find_by_email(params[:id])
    end
  end

  def cancellationsrefundpg
    @premium_plan = Subscription.find_by(title:"premium")
    if signed_in?
      @user_network_activities = Activity.order("created_at desc").where(owner_id: current_user.friends)
      @activity =  Activity.last
      @user = User.find(current_user.id)
      @friend = User.find_by_email(params[:id])
    end
  end

  def cookiepg 
    @premium_plan = Subscription.find_by(title:"premium")
    if signed_in?
      @user_network_activities = Activity.order("created_at desc").where(owner_id: current_user.friends)
      @activity =  Activity.last
      @user = User.find(current_user.id)
      @friend = User.find_by_email(params[:id])
    end 
  end

  def errorpermissionpg
    @premium_plan = Subscription.find_by(title:"premium")
    if signed_in?
      @user_network_activities = Activity.order("created_at desc").where(owner_id: current_user.friends)
      @activity =  Activity.last
      @user = User.find(current_user.id)
      @friend = User.find_by_email(params[:id])
    end
  end
  
  def errorpg
    @premium_plan = Subscription.find_by(title:"premium")
    if signed_in?
      @user_network_activities = Activity.order("created_at desc").where(owner_id: current_user.friends)
      @activity =  Activity.last
      @user = User.find(current_user.id)
      @friend = User.find_by_email(params[:id])
    end
  end

  def faqspg
    @premium_plan = Subscription.find_by(title:"premium")
    if signed_in?
      @user_network_activities = Activity.order("created_at desc").where(owner_id: current_user.friends)
      @activity =  Activity.last
      @user = User.find(current_user.id)
      @friend = User.find_by_email(params[:id])
    end
  end

  def helppg
    @premium_plan = Subscription.find_by(title:"premium")
    if signed_in?
      @user_network_activities = Activity.order("created_at desc").where(owner_id: current_user.friends)
      @activity =  Activity.last
      @user = User.find(current_user.id)
      @friend = User.find_by_email(params[:id])
    end
  end

  def homepg
    @premium_plan = Subscription.find_by(title:"premium")
  end

  def imagepg
    @premium_plan = Subscription.find_by(title:"premium")
    if signed_in?
      @user_network_activities = Activity.order("created_at desc").where(owner_id: current_user.friends)
      @activity =  Activity.last
      @user = User.find(current_user.id)
      @friend = User.find_by_email(params[:id])
    end
  end

  def landingpg
    @premium_plan = Subscription.find_by(title:"premium")
    @signup = Signup.new
  end

  def messagesentpg
    @premium_plan = Subscription.find_by(title:"premium")
    if signed_in?
      @user_network_activities = Activity.order("created_at desc").where(owner_id: current_user.friends)
      @activity =  Activity.last
      @user = User.find(current_user.id)
      @friend = User.find_by_email(params[:id])
    end
  end

  def membershippg
    @premium_plan = Subscription.find_by(title:"premium")
    if signed_in?
      @user_network_activities = Activity.order("created_at desc").where(owner_id: current_user.friends)
      @activity =  Activity.last
      @user = User.find(current_user.id)
      @friend = User.find_by_email(params[:id])
    end
  end

  def notepg
    @premium_plan = Subscription.find_by(title:"premium")
    if signed_in?
      if current_user.admin_pa_management_group
        @user_network_activities = Activity.order("created_at desc").where(owner_id: current_user.friends)
        @activity =  Activity.last
        @user = User.find(current_user.id)
        @friend = User.find_by_email(params[:id])
      else
        redirect_to errorpermission_path
      end
    end 
  end

  def partnerspg 
    @premium_plan = Subscription.find_by(title:"premium")
    if signed_in?
      @user_network_activities = Activity.order("created_at desc").where(owner_id: current_user.friends)
      @activity =  Activity.last
      @user = User.find(current_user.id)
      @friend = User.find_by_email(params[:id])
    end
  end

  def paymentqueriespg
    @premium_plan = Subscription.find_by(title:"premium")
    if signed_in?
      @user_network_activities = Activity.order("created_at desc").where(owner_id: current_user.friends)
      @activity =  Activity.last
      @user = User.find(current_user.id)
      @friend = User.find_by_email(params[:id])
    end
  end

  def privacypg
    @premium_plan = Subscription.find_by(title:"premium")
    if signed_in?
      @user_network_activities = Activity.order("created_at desc").where(owner_id: current_user.friends)
      @activity =  Activity.last
      @user = User.find(current_user.id)
      @friend = User.find_by_email(params[:id])
    end 
  end

  def sponsorshippg
    @premium_plan = Subscription.find_by(title:"premium")
    if signed_in?
      @user_network_activities = Activity.order("created_at desc").where(owner_id: current_user.friends)
      @activity =  Activity.last
      @user = User.find(current_user.id)
      @friend = User.find_by_email(params[:id])
    end
  end

  def presentationpg
    @premium_plan = Subscription.find_by(title:"premium")
    if signed_in?
      @user_network_activities = Activity.order("created_at desc").where(owner_id: current_user.friends)
      @activity =  Activity.last
      @user = User.find(current_user.id)
      @friend = User.find_by_email(params[:id])
    end
  end

  def investmentpg
    @premium_plan = Subscription.find_by(title:"premium")
    if signed_in?
      @user_network_activities = Activity.order("created_at desc").where(owner_id: current_user.friends)
      @activity =  Activity.last
      @user = User.find(current_user.id)
      @friend = User.find_by_email(params[:id])
    end
  end

  def termspg
    @premium_plan = Subscription.find_by(title:"premium")
    if signed_in?
      @user_network_activities = Activity.order("created_at desc").where(owner_id: current_user.friends)
      @activity =  Activity.last
      @user = User.find(current_user.id)
      @friend = User.find_by_email(params[:id])
    end
  end

  def informationpg
    @premium_plan = Subscription.find_by(title:"premium")
    if signed_in?
      @user_network_activities = Activity.order("created_at desc").where(owner_id: current_user.friends)
      @activity =  Activity.last
      @user = User.find(current_user.id)
      @friend = User.find_by_email(params[:id])
    end
  end

  # def user_not_allowed_to_view
  #   redirect_to root_path
  # end
  
  private
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

  def set_user
    @user = User.friendly.find(params[:id])
  end
end
