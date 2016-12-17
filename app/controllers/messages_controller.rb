class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_filter :setup_friends

  def inbox
    if current_user.image?
      @inbox = message.inbox
      @active = :inbox
    else
      redirect_to image_restriction_page_path
    end
    @premium_plan = Subscription.find_by(title:"premium")
  end

  def sent
    if current_user.subscribed_access?
      if current_user.image?
        @sent = message.sentbox
        @active = :sent
      else
      redirect_to image_restriction_page_path
      end
    else
      @premium_plan = Subscription.find_by(title:"premium") 
      redirect_to subscription_path(@premium_plan)
    end
    @premium_plan = Subscription.find_by(title:"premium")
  end

  def trash
    if current_user.subscribed_access?
      if current_user.image?
        @trash = message.trash
        @active = :trash
      else
      redirect_to image_restriction_page_path
      end
    else
      @premium_plan = Subscription.find_by(title:"premium") 
      redirect_to subscription_path(@premium_plan)
    end
    @premium_plan = Subscription.find_by(title:"premium")
  end

  private
    def setup_friends
      @user = User.find(current_user.id)
      @friend = User.find_by_email(params[:id])
    end
end



