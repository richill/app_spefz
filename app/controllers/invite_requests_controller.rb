class InviteRequestsController < ApplicationController
  before_action :set_invite_request, only: [:show, :edit, :update, :destroy]

  def index
    @invite_requests = InviteRequest.all
  end

  def show
  end

  def new
    @invite_request = InviteRequest.new
  end

  def edit
  end

  def create
    @invite_request = InviteRequest.new(invite_request_params)
    @invite_request.status = "pending"

    respond_to do |format|
      if @invite_request.save
        format.html { redirect_to :back, notice: 'Invite request was successfully created.' }
        format.json { render :show, status: :created, location: @invite_request }
      else
        format.html { render :new }
        format.json { render json: @invite_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @invite_request.update(invite_request_params)
        format.html { redirect_to @invite_request, notice: 'Invite request was successfully updated.' }
        format.json { render :show, status: :ok, location: @invite_request }
      else
        format.html { render :edit }
        format.json { render json: @invite_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @invite_request.destroy
    respond_to do |format|
      format.html { redirect_to invite_requests_url, notice: 'Invite request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_invite_request
      @invite_request = InviteRequest.find(params[:id])
    end

    def invite_request_params
      params.require(:invite_request).permit(:user_id, :inviter_id, :social_id, :event_id, :status)
    end
end
