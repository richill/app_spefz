class PreferencesController < ApplicationController
  before_action :authenticate_user!, :set_preference, only: [:show, :edit, :update, :destroy]
  before_filter :setup_friends, :setup_subscription, :setup_cards, :setup_events, :setup_invite_form, :setup_user_network_activities

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
    if current_user.subscribed_access?
      @user = current_user
      @preference = @user.build_preference
    else
      redirect_to subscription_path(@premium_plan)
    end
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
    if current_user.subscribed_access?
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
    else
      redirect_to subscription_path(@premium_plan)
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
  def set_social
    @social = Social.friendly.find(params[:id])
  end

  def setup_friends
    @user = User.find(current_user.id)
    @friend = User.find_by_email(params[:id])
  end

  def setup_subscription
    @premium_plan = Subscription.find_by(title:"premium") 
  end

  def setup_cards
    @cards = Card.all
  end

  def setup_events
    @events = Event.all
  end

  def setup_invite_form
    @invite = Invite.new
  end

  def setup_user_network_activities
    @user_network_activities = Activity.order("created_at desc").where(owner_id: current_user.friends)
    @activity =  Activity.last
  end

  # Use callbacks to share common setup or constraints between actions.
  # def set_preference
  #   @preference = Preference.find(params[:id])
  # end
  def set_preference
    @preference = Preference.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def preference_params
    params.require(:preference).permit(:town, :user_id, :name, :slug, :idealage_start, :idealage_end, :category_matchseeking_id, :category_matchrelationship_id, :category_matchstatus_id, :category_matchparent_id)
  end
end
