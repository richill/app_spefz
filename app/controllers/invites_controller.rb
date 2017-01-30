class InvitesController < ApplicationController
  before_action :set_invite, only: [:show, :edit, :update, :destroy]

  def index
    if current_user.admin_pa_management_group
      @invites = Invite.all
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
      @invite = Invite.new
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
    @invite = Invite.new(invite_params)
    @invite.status = "pending"

    respond_to do |format|
      if @invite.save
        MailerInvitemember.invitememeber(@invite).deliver
        format.html { redirect_to :back, notice: 'Invite was successfully sent' }
        format.json { render :show, status: :created, location: @invite }
      else
        format.html { redirect_to :back, alert: 'Invite was not sent.' }
        format.json { render json: @invite.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @invite.status = "declined"

    respond_to do |format|
      if @invite.update(invite_params)
        format.html { redirect_to :back }
        format.json { render :show, status: :ok, location: @invite }
      else
        format.html { render :edit }
        format.json { render json: @invite.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if current_user.admin_pa_management_group
      @invite.destroy
      respond_to do |format|
        format.html { redirect_to invites_url, notice: 'Invite was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to errorpermission_path
    end
  end

  private
    def set_invite
      @invite = Invite.find(params[:id])
    end

    def invite_params
      params.require(:invite).permit(:invitee_id, :social_id, :event_id, :status, :user_id, user_ids: [])
    end
end
