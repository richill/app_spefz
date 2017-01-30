class AttendingSocialsController < ApplicationController
  before_action :authenticate_user!, :set_social
  before_filter :setup_subscription

  def create
    if current_user.subscribed_access?
      if Attendance.find_or_create_by(attendable: @social, user: current_user)
        redirect_to :back, notice: 'Attending Social'
      else
        redirect_to :back, alert: 'Something went wrong...*sad panda*'
      end
    else
      redirect_to subscription_path(@premium_plan)
    end
  end

  
  def destroy
    Attendance.where(attendable_id: @social.id, user_id: current_user.id).first.destroy
    redirect_to :back, notice: 'Not Attending Social'
  end
  
  private
  def setup_subscription
    @premium_plan = Subscription.find_by(title:"premium") 
  end

  def set_social
    @social = Social.friendly.find(params[:social_id] || params[:id])
  end
end
