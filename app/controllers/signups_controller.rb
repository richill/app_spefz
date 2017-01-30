class SignupsController < ApplicationController
  before_action :set_signup, only: [:show, :edit, :update, :destroy]

  # GET /signups
  # GET /signups.json
  def index
    if current_user.admin_pa_management_group
      @signups = Signup.all
    else
      redirect_to subscription_path(@premium_plan)
    end
  end

  # GET /signups/1
  # GET /signups/1.json
  def show
    unless current_user.admin_pa_management_group
      redirect_to errorpermission_path
    end
  end

  # GET /signups/new
  def new
    if current_user.admin_pa_management_group
      @signup = Signup.new
    else
      redirect_to subscription_path(@premium_plan)
    end
  end

  # GET /signups/1/edit
  def edit
    unless current_user.admin_pa_management_group
      redirect_to errorpermission_path
    end
  end

  # POST /signups
  # POST /signups.json
  def create
    @signup = Signup.new(signup_params)
    respond_to do |format|
      if @signup.save
        format.html { redirect_to root_path, notice: 'Thank You! You have been successfully added to our Beta List.' }
        format.json { render json: @signup, status: :created, location: @signup }
      else
        format.html { redirect_to root_path, alert: 'Ensure all fields are completed' }
        format.json { render json: @signup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /signups/1
  # PATCH/PUT /signups/1.json
  def update
    if current_user.admin_pa_management_group
      respond_to do |format|
        if @signup.update(signup_params)
          format.html { redirect_to @signup, notice: 'Signup was successfully updated.' }
          format.json { render :show, status: :ok, location: @signup }
        else
          format.html { render :edit }
          format.json { render json: @signup.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to subscription_path(@premium_plan)
    end
  end

  # DELETE /signups/1
  # DELETE /signups/1.json
  def destroy
    if current_user.admin_pa_management_group
      @signup.destroy
      respond_to do |format|
        format.html { redirect_to signups_url, notice: 'Signup was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to subscription_path(@premium_plan)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_signup
      @signup = Signup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def signup_params
      params.require(:signup).permit(:name, :email)
    end
end
