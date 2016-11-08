class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    if current_user.subscribed_access?
      @user = User.find(params[:followed_id])
      current_user.follow(@user)
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
      @user = Relationship.find(params[:id]).followed
      current_user.unfollow(@user)
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    else
      @premium_plan = Subscription.find_by(title:"premium") 
      redirect_to subscription_path(@premium_plan)
    end
  end
end




