class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_filter :setup_friends

  # Sends a friend request.
  # We'd rather call this "request", but that's not allowed by Rails.
  def create
    Friendship.request(@user, @friend)
    flash[:notice] = "Request sent."
    redirect_to :back
    MailerFriendrequest.friend_request(@user, @friend).deliver
  end

  # Accepts a friend request.
  # We'd rather call this "accept", but that's not allowed by Rails.
  def update
    @user = User.friendly.find(params[:user_id])
    @friend = User.friendly.find(params[:friend_id])
    if @user.requested_friends.include?(@friend)
      Friendship.accept(@user, @friend)
      flash[:notice] = "You and #{@friend.firstname} are now connected"
    else
      flash[:notice] = "No connect request from #{@friend.firstname}."
    end
    redirect_to :back
  end

  def destroy
    @user = User.friendly.find(params[:user_id])
    @friend = User.friendly.find(params[:friend_id])
    if @user.requested_friends.include?(@friend) #decline
      Friendship.breakup(@user, @friend)
      redirect_to :back
    elsif @user.pending_friends.include?(@friend) #cancel
      Friendship.breakup(@user, @friend)
      redirect_to :back
    elsif @user.friends.include?(@friend) #delete
      Friendship.breakup(@user, @friend)
      redirect_to :back
    end
  end

  def decline
    @user = User.friendly.find(params[:user_id])
    @friend = User.friendly.find(params[:friend_id])
    if @user.requested_friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:notice] = "Connection with #{@friend.firstname} declined"
    else
      flash[:notice] = "No connect request from #{@friend.firstname}."
    end
    redirect_to :back
  end

  def cancel
    @user = User.friendly.find(params[:user_id])
    @friend = User.friendly.find(params[:friend_id])
    if @user.pending_friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:notice] = "Connection request canceled."
    else
      flash[:notice] = "No request for connection with #{@friend.firstname}"
    end
    redirect_to :back
  end

  def delete
    @user = User.friendly.find(params[:user_id])
    @friend = User.friendly.find(params[:friend_id])
    if @user.friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:notice] = "Connection with #{@friend.firstname} deleted!"
    else
      flash[:notice] = "You aren't connected with #{@friend.firstname}"
    end
    redirect_to :back
  end

  private
  def setup_friends
    @user = User.find(current_user.id)
    @friend = User.find_by_email(params[:id])
  end
end
