class ExternalattendinglistsController < ApplicationController
  before_action :set_externalattendinglist, only: [:show, :edit, :update, :destroy]
  respond_to :html, :xml, :json

  def index
    if current_user.admin_pa_management_group || current_user.pa_event_mgt_group
      @externalattendinglists = Externalattendinglist.all
    else
      redirect_to errorpermission_path
    end
  end

  def show
    unless current_user.admin_pa_management_group || current_user.pa_event_mgt_group
      redirect_to errorpermission_path
    end
  end

  def new
    if current_user.admin_pa_management_group || current_user.pa_event_mgt_group
      @event = Event.friendly.find(params[:event_id])
      @externalattendinglist = Externalattendinglist.new
      @externalattendinglist.event = @event
      @search = User.search(params[:q])
      @users = @search.result(distinct: true)
      respond_with(@externalattendinglist)
    else
      redirect_to errorpermission_path
    end
  end

  def edit
    if current_user.admin_pa_management_group || current_user.pa_event_mgt_group
      @event = Event.friendly.find(params[:event_id])
      @search = User.search(params[:q])
      @users = @search.result(distinct: true)
    else
      redirect_to errorpermission_path
    end
  end

  def create
    if current_user.admin_pa_management_group || current_user.pa_event_mgt_group
      @event = Event.friendly.find(params[:event_id])
      @event.externalattendinglist = Externalattendinglist.new(externalattendinglist_params)
      @externalattendinglist = @event.externalattendinglist
      @search = User.search(params[:q])
      @users = @search.result(distinct: true)
      respond_to do |format|
        if @externalattendinglist.save   
          format.html { redirect_to(attendants_event_path(@event), notice: 'External Attending List Successfully Created.') }
          format.json { render :show, status: :created, location: @externalattendinglist }
        else
          format.html { redirect_to :back, alert: 'External Attending List Was Not created.' }
          format.json { render json: @externalattendinglist.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to errorpermission_path
    end
  end

  def update
    if current_user.admin_pa_management_group || current_user.pa_event_mgt_group
      @event = Event.friendly.find(params[:event_id])
      @externalattendinglist = @event.externalattendinglist
      respond_to do |format|
        if @externalattendinglist.update(externalattendinglist_params)
          format.html { redirect_to(attendants_event_path(@event), notice: 'External Attending List Successfully Updated.') }
          format.json { render :show, status: :ok, location: @externalattendinglist }
        else
          format.html { render :edit }
          format.json { render json: @externalattendinglist.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to errorpermission_path
    end
  end

  def destroy
    if current_user.admin_pa_management_group || current_user.pa_event_mgt_group
      @event = Event.friendly.find(params[:event_id])
      @externalattendinglist = @event.externalattendinglists.find(params[:id])
      @externalattendinglist.destroy
      respond_to do |format|
        format.html { redirect_to externalattendinglists_url, notice: 'External Attending List Successfully Destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to errorpermission_path
    end
  end

  private
    def set_externalattendinglist
      @externalattendinglist = Externalattendinglist.find(params[:id])
    end

    def externalattendinglist_params
      params.require(:externalattendinglist).permit(:event_id, :user_id, :reference, user_ids: [])
    end
end
