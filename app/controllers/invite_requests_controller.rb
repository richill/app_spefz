class InviteRequestsController < ApplicationController
  before_action :authenticate_user!, :set_invite_request, only: [:show, :edit, :update, :destroy]
  before_filter :setup_subscription

  def index
    if current_user.admin_pa_management_group
      @invite_requests = InviteRequest.all
    else
      redirect_to errorpermission_path
    end
  end

  def show
    unless current_user.admin_pa_management_group
      redirect_to errorpermission_path
    end
  end

  def new
    if current_user.admin_pa_management_group
     @invite_request = InviteRequest.new
    else
      redirect_to errorpermission_path
    end
  end

  def edit
    unless current_user.admin_pa_management_group
      redirect_to errorpermission_path
    end
  end

  def create
    if current_user.subscribed_access?
      @invite_request = InviteRequest.new(invite_request_params)
      @invite_request.status = "pending"

      respond_to do |format|
        if @invite_request.save
          format.html { redirect_to :back, notice: 'Invite request was successfully sent.' }
          format.json { render :show, status: :created, location: @invite_request }
        else
          format.html { render :new }
          format.json { render json: @invite_request.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to subscription_path(@premium_plan)
    end
  end

  def update
    if current_user.admin_pa_management_group
      respond_to do |format|
        if @invite_request.update(invite_request_params)
          format.html { redirect_to :back, notice: 'Invite request was successfully updated.' }
          format.json { render :show, status: :ok, location: @invite_request }
        else
          format.html { render :edit }
          format.json { render json: @invite_request.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to errorpermission_path
    end
  end

  def destroy
    if current_user.admin_pa_management_group
      @invite_request.destroy
      respond_to do |format|
        format.html { redirect_to :back, notice: 'Invite request was successfully declined.' }
        format.json { head :no_content }
      end
    else
      redirect_to errorpermission_path
    end
  end

  private
  def setup_subscription
    @premium_plan = Subscription.find_by(title:"premium") 
  end

  def set_invite_request
    @invite_request = InviteRequest.find(params[:id])
  end

  def invite_request_params
    params.require(:invite_request).permit(:user_id, :inviter_id, :social_id, :event_id, :status)
  end
end
