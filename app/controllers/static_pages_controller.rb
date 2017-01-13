class StaticPagesController < ApplicationController
  # before_filter :user_not_allowed_to_view, only: [:homepg]
  before_filter :setup_subscription, :setup_cards, :setup_events, :setup_invite_form

  def aboutpg
    @premium_plan = Subscription.find_by(title:"premium")
  end

  def accountpg 
    @premium_plan = Subscription.find_by(title:"premium")
  end

  def cancellationsrefundpg
    @premium_plan = Subscription.find_by(title:"premium")
  end

  def cookiepg 
    @premium_plan = Subscription.find_by(title:"premium") 
  end

  def errorpermissionpg
    @premium_plan = Subscription.find_by(title:"premium")
  end
  
  def errorpg
    @premium_plan = Subscription.find_by(title:"premium")
  end

  def faqspg
    @premium_plan = Subscription.find_by(title:"premium")
  end

  def helppg
    @premium_plan = Subscription.find_by(title:"premium")
  end

  def homepg
    @premium_plan = Subscription.find_by(title:"premium")
  end

  def imagepg
    @premium_plan = Subscription.find_by(title:"premium")
  end

  def landingpg
    @premium_plan = Subscription.find_by(title:"premium")
    @signup = Signup.new
  end

  def messagesentpg
    @premium_plan = Subscription.find_by(title:"premium")
  end

  def membershippg
    @premium_plan = Subscription.find_by(title:"premium")
  end

  def notepg
    @premium_plan = Subscription.find_by(title:"premium") 
  end

  def partnerspg 
    @premium_plan = Subscription.find_by(title:"premium")
  end

  def paymentqueriespg
    @premium_plan = Subscription.find_by(title:"premium")
  end

  def privacypg
    @premium_plan = Subscription.find_by(title:"premium") 
  end

  def termspg
    @premium_plan = Subscription.find_by(title:"premium")
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
