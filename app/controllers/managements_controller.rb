class ManagementsController < ApplicationController
  before_action :set_management, only: [:show, :edit, :update, :destroy]

  # GET /managements
  # GET /managements.json
  def index
    @managements = Management.all
  end

  # GET /managements/1
  # GET /managements/1.json
  def show
  end

  # GET /managements/new
  def new
    @management = Management.new
  end

  # GET /managements/1/edit
  def edit
  end

  # POST /managements
  # POST /managements.json
  def create
    @management = Management.new(management_params)

    respond_to do |format|
      if @management.save
        format.html { redirect_to @management, notice: 'Management was successfully created.' }
        format.json { render :show, status: :created, location: @management }
      else
        format.html { render :new }
        format.json { render json: @management.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /managements/1
  # PATCH/PUT /managements/1.json
  def update
    respond_to do |format|
      if @management.update(management_params)
        format.html { redirect_to @management, notice: 'Management was successfully updated.' }
        format.json { render :show, status: :ok, location: @management }
      else
        format.html { render :edit }
        format.json { render json: @management.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /managements/1
  # DELETE /managements/1.json
  def destroy
    @management.destroy
    respond_to do |format|
      format.html { redirect_to managements_url, notice: 'Management was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_management
      @management = Management.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def management_params
      params.require(:management).permit(:venuecost, :hostcost)
    end
end
