class HostsController < ApplicationController
  before_action :set_host, only: [:show, :edit, :update, :destroy]

  def index
    @hosts = Host.all
  end

  def show
  end

  def new
    @host = Host.new
  end

  def edit
  end

  def create
    @host = Host.new(host_params)

    respond_to do |format|
      if @host.save
        format.html { redirect_to user_event_path(@host.event.user, @host.event), notice: 'Host was successfully created.' }
        format.json { render :show, status: :created, location: @host }
      else
        format.html { render :new }
        format.json { render json: @host.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @host.update(host_params)
        format.html { redirect_to user_event_path(@host.event.user, @host.event), notice: 'Host was successfully updated.' }
        format.json { render :show, status: :ok, location: @host }
      else
        format.html { render :edit }
        format.json { render json: @host.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
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
