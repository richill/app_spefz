class HostsController < ApplicationController
  before_action :authenticate_user!, :set_host, only: [:show, :edit, :update, :destroy]

  def index
    if current_user.admin_pa_management_group 
      @hosts = Host.all
    else
      redirect_to errorpermission_path
    end
  end

  def show
    if current_user.admin_pa_management_group
    unless current_user.admin_pa_management_group
      redirect_to errorpermission_path
    end
  end

  def new
    if current_user.admin_pa_management_group || current_user.pa_event_mgt_group
      @event = Event.friendly.find(params[:event_id])
      @host = @event.hosts.build
    else
      redirect_to errorpermission_path
    end
  end

  def edit
    if current_user.admin_pa_management_group || current_user.pa_event_mgt_group
      @event = Event.friendly.find(params[:event_id])
    else
      redirect_to errorpermission_path
    end
  end

  def create
    if current_user.admin_pa_management_group || current_user.pa_event_mgt_group
      @event = Event.friendly.find(params[:event_id])
      @event.host = Host.new(host_params)
      @host = @event.host
      respond_to do |format|
        if @host.save
          format.html { redirect_to(event_path(@event), notice: 'Host was successfully created.') }
          format.json { render :show, status: :created, location: @host }
        else
          format.html { redirect_to :back, alert: 'Hosts for the event was not created.' }
          format.json { render json: @host.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to errorpermission_path
    end
  end

  def update
    if current_user.admin_pa_management_group || current_user.pa_event_mgt_group
      @event = Event.friendly.find(params[:event_id])
      @host = @event.host
      respond_to do |format|
        if @host.update(host_params)
          format.html { redirect_to(event_path(@event), notice: 'Host was successfully updated.') }
          format.html { redirect_to([@host.event, @host], notice: 'Host was successfully updated.') }
          format.json { render :show, status: :ok, location: @host }
        else
          format.html { render :edit }
          format.json { render json: @host.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to errorpermission_path
    end
  end

  def destroy
    if current_user.admin_pa_management_group
      @event = Event.friendly.find(params[:event_id])
      @host = @event.hosts.find(params[:id])
      @host.destroy
      respond_to do |format|
        format.html { redirect_to hosts_url, notice: 'Host was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to errorpermission_path
    end
  end

  private
    def set_host
      @host = Host.find(params[:id])
    end

    def host_params
      params.require(:host).permit(:event_id, user_ids: [])
    end
end
