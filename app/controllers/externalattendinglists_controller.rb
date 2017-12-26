class ExternalattendinglistsController < ApplicationController
  before_action :set_externalattendinglist, only: [:show, :edit, :update, :destroy]

  def index
    @externalattendinglists = Externalattendinglist.all
  end

  def show
  end

  def new
    @externalattendinglist = Externalattendinglist.new
  end

  def edit
  end

  def create
    @externalattendinglist = Externalattendinglist.new(externalattendinglist_params)

    respond_to do |format|
      if @externalattendinglist.save
        format.html { redirect_to @externalattendinglist, notice: 'Externalattendinglist was successfully created.' }
        format.json { render :show, status: :created, location: @externalattendinglist }
      else
        format.html { render :new }
        format.json { render json: @externalattendinglist.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @externalattendinglist.update(externalattendinglist_params)
        format.html { redirect_to @externalattendinglist, notice: 'Externalattendinglist was successfully updated.' }
        format.json { render :show, status: :ok, location: @externalattendinglist }
      else
        format.html { render :edit }
        format.json { render json: @externalattendinglist.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @externalattendinglist.destroy
    respond_to do |format|
      format.html { redirect_to externalattendinglists_url, notice: 'Externalattendinglist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_externalattendinglist
      @externalattendinglist = Externalattendinglist.find(params[:id])
    end
    
    def externalattendinglist_params
      params.require(:externalattendinglist).permit(:event_id, :user_id, user_ids: [])
    end
end
