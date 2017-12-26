class ExternalattendinglistsController < ApplicationController
  before_action :set_externalattendinglist, only: [:show, :edit, :update, :destroy]
  respond_to :html, :xml, :json

  def index
    @externalattendinglists = Externalattendinglist.all
  end

  def show
  end

  def new
    @event = Event.friendly.find(params[:event_id])
    @externalattendinglist = Externalattendinglist.new
    @externalattendinglist.event = @event
    respond_with(@externalattendinglist)
  end

  def edit
    @event = Event.friendly.find(params[:event_id])
  end

  def create
    @event = Event.friendly.find(params[:event_id])
    @event.externalattendinglist = Externalattendinglist.new(externalattendinglist_params)
    @externalattendinglist = @event.externalattendinglist
    respond_to do |format|
      if @externalattendinglist.save   
        format.html { redirect_to(attendants_event_path(@event), notice: 'External Attendinglist was successfully created.') }
        format.json { render :show, status: :created, location: @externalattendinglist }
      else
        format.html { redirect_to :back, alert: 'External Attendinglist for the event was not created.' }
        format.json { render json: @externalattendinglist.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @event = Event.friendly.find(params[:event_id])
    @externalattendinglist = @event.externalattendinglist
    respond_to do |format|
      if @externalattendinglist.update(externalattendinglist_params)
        format.html { redirect_to(attendants_event_path(@event), notice: 'Externalattendinglist was successfully updated.') }
        format.html { redirect_to([@externalattendinglist.event, @externalattendinglist], notice: 'Externalattendinglist was successfully updated.') }
        format.json { render :show, status: :ok, location: @externalattendinglist }
      else
        format.html { render :edit }
        format.json { render json: @externalattendinglist.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event = Event.friendly.find(params[:event_id])
    @externalattendinglist = @event.externalattendinglists.find(params[:id])
    @externalattendinglist.destroy
    respond_to do |format|
      format.html { redirect_to externalattendinglists_url, notice: 'Externalattendinglist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # def index
  #   @externalattendinglists = Externalattendinglist.all
  # end

  # def show
  # end

  # def new
  #   @externalattendinglist = Externalattendinglist.new
  # end

  # def edit
  # end

  # def create
  #   @externalattendinglist = Externalattendinglist.new(externalattendinglist_params)

  #   respond_to do |format|
  #     if @externalattendinglist.save
  #       format.html { redirect_to @externalattendinglist, notice: 'Externalattendinglist was successfully created.' }
  #       format.json { render :show, status: :created, location: @externalattendinglist }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @externalattendinglist.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # def update
  #   respond_to do |format|
  #     if @externalattendinglist.update(externalattendinglist_params)
  #       format.html { redirect_to @externalattendinglist, notice: 'Externalattendinglist was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @externalattendinglist }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @externalattendinglist.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # def destroy
  #   @externalattendinglist.destroy
  #   respond_to do |format|
  #     format.html { redirect_to externalattendinglists_url, notice: 'Externalattendinglist was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    def set_externalattendinglist
      @externalattendinglist = Externalattendinglist.find(params[:id])
    end

    def externalattendinglist_params
      params.require(:externalattendinglist).permit(:event_id, :user_id, :reference, user_ids: [])
    end
end
