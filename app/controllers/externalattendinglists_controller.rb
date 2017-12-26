class ExternalattendinglistsController < ApplicationController
  before_action :set_externalattendinglist, only: [:show, :edit, :update, :destroy]

  # GET /externalattendinglists
  # GET /externalattendinglists.json
  def index
    @externalattendinglists = Externalattendinglist.all
  end

  # GET /externalattendinglists/1
  # GET /externalattendinglists/1.json
  def show
  end

  # GET /externalattendinglists/new
  def new
    @externalattendinglist = Externalattendinglist.new
  end

  # GET /externalattendinglists/1/edit
  def edit
  end

  # POST /externalattendinglists
  # POST /externalattendinglists.json
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

  # PATCH/PUT /externalattendinglists/1
  # PATCH/PUT /externalattendinglists/1.json
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

  # DELETE /externalattendinglists/1
  # DELETE /externalattendinglists/1.json
  def destroy
    @externalattendinglist.destroy
    respond_to do |format|
      format.html { redirect_to externalattendinglists_url, notice: 'Externalattendinglist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_externalattendinglist
      @externalattendinglist = Externalattendinglist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def externalattendinglist_params
      params.require(:externalattendinglist).permit(:event_id, :user_id)
    end
end
