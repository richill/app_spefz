class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_filter :setup_friends, :setup_subscription, :setup_cards, :setup_events, :setup_invite_form, :setup_user_network_activities

  def new
    unless current_user.subscribed_access?
      @premium_plan = Subscription.find_by(title:"premium") 
      redirect_to subscription_path(@premium_plan)
    end
  end

  def create
    if current_user.subscribed_access?
      recipients = User.where(id: conversation_params[:recipients])
      conversation = current_user.send_message(recipients, conversation_params[:body], conversation_params[:subject]).conversation
      flash[:success] = "Your message was successfully sent!"
      redirect_to conversation_path(conversation)
      # redirect_to message_sent_path
    else
      @premium_plan = Subscription.find_by(title:"premium") 
      redirect_to subscription_path(@premium_plan)
    end
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
    if current_user.subscribed_access?
      current_user.reply_to_conversation(conversation, message_params[:body])
      flash[:notice] = "Your reply message was successfully sent!"
      redirect_to conversation_path(conversation)
    else
      @premium_plan = Subscription.find_by(title:"premium") 
      redirect_to subscription_path(@premium_plan)
    end
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

  def setup_invite_form
    @invite = Invite.new
  end

  def setup_user_network_activities
    @user_network_activities = Activity.order("created_at desc").where(owner_id: current_user.friends)
    @activity =  Activity.last
  end

  def conversation_params
    params.require(:conversation).permit(:subject, :body, recipients:[])
  end

  def message_params
    params.require(:messages).permit(:body, :subject)
  end
end



