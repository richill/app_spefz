class PreferencesController < ApplicationController
  before_action :set_preference, only: [:show, :edit, :update, :destroy]

  # GET /preferences
  # GET /preferences.json
  def index
    @preferences = Preference.all
  end

  # GET /preferences/1
  # GET /preferences/1.json
  # def show
  # end
  def show
    @user = User.friendly.find(params[:user_id])
    @preference = @user.preference
  end

  # GET /preferences/new
  # def new
  #   @preference = Preference.new
  # end
  def new
    @user = current_user
    @preference = @user.build_preference
  end

  # GET /preferences/1/edit
  # def edit
  # end
  def edit
    @user = User.friendly.find(params[:user_id])
  end

  # POST /preferences
  # POST /preferences.json
  # def create
  #   @preference = Preference.new(preference_params)

  #   respond_to do |format|
  #     if @preference.save
  #       format.html { redirect_to @preference, notice: 'Preference was successfully created.' }
  #       format.json { render :show, status: :created, location: @preference }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @preference.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  def create
    @user = User.friendly.find(params[:user_id])
    @user.preference = Preference.new(preference_params)
    @preference = @user.preference

    respond_to do |format|
      if @preference.save
        format.html { redirect_to @preference, notice: 'Preference was successfully created.' }
        format.json { render :show, status: :created, location: @preference }
      else
        format.html { render :new }
        format.json { render json: @preference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /preferences/1
  # PATCH/PUT /preferences/1.json
  # def update
  #   respond_to do |format|
  #     if @preference.update(preference_params)
  #       format.html { redirect_to @preference, notice: 'Preference was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @preference }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @preference.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  def update
    respond_to do |format|
      if @preference.update(preference_params)
        format.html { redirect_to([@preference.user, @preference], notice: 'Preference was successfully updated.') }
        format.json { render :show, status: :ok, location: @preference }
      else
        format.html { render :edit }
        format.json { render json: @preference.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /preferences/1
  # DELETE /preferences/1.json
  # def destroy
  #   @preference.destroy
  #   respond_to do |format|
  #     format.html { redirect_to preferences_url, notice: 'Preference was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end
  def destroy
    @user = current_user
    @preference = @user.preference
    @preference.destroy
    respond_to do |format|
      format.html { redirect_to user_url(@user), notice: 'Preference was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_preference
    #   @preference = Preference.find(params[:id])
    # end
    def set_preference
      @preference = Preference.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def preference_params
      params.require(:preference).permit(:town)
    end
end
