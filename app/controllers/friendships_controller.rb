# class FriendshipsController < ApplicationController
#   before_action :authenticate_user!

#   def create
#     if current_user.subscribed_access?
#       @user = User.find(params[:friended_id])
#       current_user.friend(@user)
#       respond_to do |format|
#         format.html { redirect_to :back }
#         format.js
#       end
#     else
#       @premium_plan = Subscription.find_by(title:"premium") 
#       redirect_to subscription_path(@premium_plan)
#     end
#   end

#   def destroy
#     if current_user.subscribed_access?
#       @user = Friendship.find(params[:id]).friended
#       current_user.unfriend(@user)
#       respond_to do |format|
#         format.html { redirect_to :back }
#         format.js
#       end
#     end
#   else
#     @premium_plan = Subscription.find_by(title:"premium") 
#     redirect_to subscription_path(@premium_plan)
#   end
# end



class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_filter :setup_friends

  # Sends a friend request.
  # We'd rather call this "request", but that's not allowed by Rails.
  def create
    Friendship.request(@user, @friend)
    flash[:notice] = "Friend request sent."
    redirect_to :back
  end

  # Accepts a friend request.
  # We'd rather call this "accept", but that's not allowed by Rails.
  def update
    @user = User.find(params[:user_id])
    @friend = User.find(params[:friend_id])
    if @user.requested_friends.include?(@friend)
      Friendship.accept(@user, @friend)
      flash[:notice] = "Friendship with #{@friend.firstname} accepted!"
    else
      flash[:notice] = "No friendship request from #{@friend.firstname}."
    end
    redirect_to :back
  end

  def destroy
    @user = User.find(params[:user_id])
    @friend = User.find(params[:friend_id])
    if @user.requested_friends.include?(@friend) #decline
      Friendship.breakup(@user, @friend)
      redirect_to user_path(current_user)
    elsif @user.pending_friends.include?(@friend) #cancel
      Friendship.breakup(@user, @friend)
      redirect_to user_path(current_user)
    elsif @user.friends.include?(@friend) #delete
      Friendship.breakup(@user, @friend)
      redirect_to user_path(current_user)
    end
  end

  def decline
    @user = User.find(params[:user_id])
    @friend = User.find(params[:friend_id])
    if @user.requested_friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:notice] = "Friendship with #{@friend.firstname} declined"
    else
      flash[:notice] = "No friendship request from #{@friend.firstname}."
    end
    redirect_to :back
  end

  def cancel
    @user = User.find(params[:user_id])
    @friend = User.find(params[:friend_id])
    if @user.pending_friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:notice] = "Friendship request canceled."
    else
      flash[:notice] = "No request for friendship with #{@friend.firstname}"
    end
    redirect_to :back
  end

  def delete
    @user = User.find(params[:user_id])
    @friend = User.find(params[:friend_id])
    if @user.friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:notice] = "Friendship with #{@friend.firstname} deleted!"
    else
      flash[:notice] = "You aren't friends with #{@friend.firstname}"
    end
    redirect_to :back
  end

  private
  def setup_friends
    @user = User.find(current_user.id)
    @friend = User.find_by_email(params[:id])
  end
end
