class AttendingSocialsController < ApplicationController
  before_action :set_social

  def create
    if Attendance.create(attendable: @social, user: current_user)
      redirect_to :back, notice: 'Attending Social'
    else
      redirect_to :back, alert: 'Something went wrong...*sad panda*'
    end
  end
  
  def destroy
    Attendance.where(attendable_id: @social.id, user_id: current_user.id).first.destroy
    redirect_to :back, notice: 'Not Attending Social'
  end
  
  private
  def set_social
    @social = Social.find(params[:social_id] || params[:id])
  end
end
