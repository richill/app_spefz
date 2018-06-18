class BusinessadsController < ApplicationController
  before_action :set_businessad, only: [:show, :edit, :update, :destroy]

  def index
    if current_user.admin_pa_management_group || current_user.pa_event_mgt_group
      @businessads = Businessad.all
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
      @businessad = Businessad.new
    else
      redirect_to errorpermission_path
    end
  end

  def edit
  end

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

  def destroy
    @businessad.destroy
    respond_to do |format|
      format.html { redirect_to businessads_url, notice: 'Businessad was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_businessad
      @businessad = Businessad.find(params[:id])
    end

    def businessad_params
      params.require(:businessad).permit(:name, :content, :link, :image, :displaytext, :category_advert_id, :event_id)
    end
end
