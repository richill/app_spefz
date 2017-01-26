class HostsController < ApplicationController
  before_action :set_host, only: [:show, :edit, :update, :destroy]

  def index
    @hosts = Host.all
  end

  def show
  end

  def new
    @event = Event.friendly.find(params[:event_id])
    @host = @event.hosts.build
  end

  def edit
    @event = Event.friendly.find(params[:event_id])
  end

  def create
    @event = Event.friendly.find(params[:event_id])
    @event.host = Host.new(host_params)
    @host = @event.host
    respond_to do |format|
      if @host.save
        format.html { redirect_to(event_path(@event), notice: 'Host was successfully created.') }
        format.json { render :show, status: :created, location: @host }
      else
        format.html { render :new }
        format.json { render json: @host.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
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
  end

  def destroy
    @event = Event.friendly.find(params[:event_id])
    @host = @event.hosts.find(params[:id])
    @host.destroy
    respond_to do |format|
      format.html { redirect_to hosts_url, notice: 'Host was successfully destroyed.' }
      format.json { head :no_content }
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
