class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def new
    unless current_user.subscribed_access?
      @premium_plan = Subscription.find_by(title:"premium") 
      redirect_to subscription_path(@premium_plan)
    end
  end

  def create
    recipients = User.where(id: conversation_params[:recipients])
    conversation = current_user.send_message(recipients, conversation_params[:body], conversation_params[:subject]).conversation
    flash[:success] = "Your message was successfully sent!"
    redirect_to conversation_path(conversation)
    # redirect_to message_sent_path
  end

  def show
    if current_user.subscribed_access?
      @receipts = conversation.receipts_for(current_user)
      # mark conversation as read
      conversation.mark_as_read(current_user)
    else
      @premium_plan = Subscription.find_by(title:"premium") 
      redirect_to subscription_path(@premium_plan)
    end
  end

  def reply
    current_user.reply_to_conversation(conversation, message_params[:body])
    flash[:notice] = "Your reply message was successfully sent!"
    redirect_to conversation_path(conversation)
  end

  def trash
    conversation.move_to_trash(current_user)
    redirect_to message_inbox_path
  end

  def untrash
    conversation.untrash(current_user)
    redirect_to message_inbox_path
  end


  private

  def conversation_params
    params.require(:conversation).permit(:subject, :body, recipients:[])
  end

  def message_params
    params.require(:messages).permit(:body, :subject)
  end
end



