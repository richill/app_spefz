class MessagesController < ApplicationController
  before_action :authenticate_user!

  def inbox
    @inbox = message.inbox
    @active = :inbox
  end

  def sent
    if current_user.subscribed_access?
      @sent = message.sentbox
      @active = :sent
    else
      @premium_plan = Subscription.find_by(title:"premium") 
      redirect_to subscription_path(@premium_plan)
    end
  end

  def trash
    @trash = message.trash
    @active = :trash
  end
end



