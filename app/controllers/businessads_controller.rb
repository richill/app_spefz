class BusinessadsController < ApplicationController
  before_action :set_businessad, only: [:show, :edit, :update, :destroy]

  # GET /businessads
  # GET /businessads.json
  def index
    @businessads = Businessad.all
  end

  # GET /businessads/1
  # GET /businessads/1.json
  def show
  end

  # GET /businessads/new
  def new
    @businessad = Businessad.new
  end

  # GET /businessads/1/edit
  def edit
  end

  # POST /businessads
  # POST /businessads.json
  def create
    @businessad = Businessad.new(businessad_params)

    respond_to do |format|
      if @businessad.save
        format.html { redirect_to @businessad, notice: 'Businessad was successfully created.' }
        format.json { render :show, status: :created, location: @businessad }
      else
        format.html { render :new }
        format.json { render json: @businessad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /businessads/1
  # PATCH/PUT /businessads/1.json
  def update
    respond_to do |format|
      if @businessad.update(businessad_params)
        format.html { redirect_to @businessad, notice: 'Businessad was successfully updated.' }
        format.json { render :show, status: :ok, location: @businessad }
      else
        format.html { render :edit }
        format.json { render json: @businessad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /businessads/1
  # DELETE /businessads/1.json
  def destroy
    @businessad.destroy
    respond_to do |format|
      format.html { redirect_to businessads_url, notice: 'Businessad was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_businessad
      @businessad = Businessad.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def businessad_params
      params.require(:businessad).permit(:name, :content, :link, :image, :displaytext, :category_advert_id, :event_id)
    end
end
