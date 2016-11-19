class MessagesController < ApplicationController
  before_action :authenticate_user!

  def inbox
    if current_user.image?
      @inbox = message.inbox
      @active = :inbox
    else
      redirect_to image_restriction_page_path
    end
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
  end
end



