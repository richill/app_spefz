class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:friended_id])
    current_user.friend(@user)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).friended
    current_user.unfriend(@user)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
end
