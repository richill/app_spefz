class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    if current_user.subscribed_access?
      @user = User.find(params[:friended_id])
      current_user.friend(@user)
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    else
      @premium_plan = Subscription.find_by(title:"premium") 
      redirect_to subscription_path(@premium_plan)
    end
  end

  def destroy
    if current_user.subscribed_access?
      @user = Friendship.find(params[:id]).friended
      current_user.unfriend(@user)
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  else
    @premium_plan = Subscription.find_by(title:"premium") 
    redirect_to subscription_path(@premium_plan)
  end
end
