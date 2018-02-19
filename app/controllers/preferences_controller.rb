class PreferencesController < ApplicationController
  before_action :authenticate_user!, :set_preference, only: [:show, :edit, :update, :destroy]
  before_filter :setup_friends, :setup_subscription, :setup_cards, :setup_events, :setup_invite_form, :setup_user_network_activities

  def index
    if current_user.admin_pa_management_group || current_user == @user
      @preferences = Preference.all
    else
      redirect_to errorpermission_path
    end
  end

  def show
    unless current_user == @user
      # @user = User.friendly.find(params[:user_id])
      @users = User.random
      @user = current_user
      @preference = @user.preference
    end
  end

  def new
    @users = User.random
    unless current_user == @user
      @user = current_user
      @preference = @user.build_preference
    end
  end

  def edit
    @users = User.random
    unless current_user == @user
      @user = User.friendly.find(params[:user_id])
    end
  end


  def create
    unless current_user == @user
      @users = User.all
      @preference = Preference.new(preference_params)
      @preference.user = current_user

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
  end

  def update
    unless current_user == @user
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
  end

  def destroy
    unless current_user == @user
      @user = current_user
      @preference = @user.preference
      @preference.destroy
      respond_to do |format|
        format.html { redirect_to user_url(@user), notice: 'Preference was successfully destroyed.' }
        format.json { head :no_content }
      end
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

  def set_preference
    @preference = Preference.friendly.find(params[:id])
  end

  def preference_params
    params.require(:preference).permit(:town, :user_id, :name, :slug, :idealage_start, :idealage_end, :category_matchseeking_id, :category_matchrelationship_id, :category_matchstatus_id, :category_matchparent_id, :category_matchkid_id, :category_matcheducation_id, :category_matchheight_id, :category_matchbodytype_id, :category_matchethnicity_id, :category_matchreligion_id, :category_matchsmoke_id, :category_idealrelationship_id, :category_idealparent_id, :category_idealkid_id, category_idealstatus_ids: [], category_idealeducation_ids: [], category_idealheight_ids: [], category_idealbodytype_ids: [], category_idealethnicity_ids: [], category_idealreligion_ids: [], category_idealsmoke_ids: [] )
  end
end
