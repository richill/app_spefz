class UsersController < ApplicationController
  respond_to :html, :xml, :json
  before_action :authenticate_user!, :set_user, only: [:show, :edit, :update, :destroy, :followings, :followers, :dashboard, :membership, :account, :settings]
  before_filter :setup_friends, :setup_subscription, :setup_cards, :setup_events, :setup_invite_form, :setup_user_network_activities

  def index
    if params[:tag]
      @users = User.tagged_with(params[:tag])
      @search = User.search(params[:q])
      @listed_users = @search.result(distinct: true)
    else
      if current_user.admin_pa_management_group
        @search = User.search(params[:q])
        @users = @search.result(distinct: true)
      else
        redirect_to errorpermission_path
      end
    end 
  end

  def show
    @user = User.friendly.find(params[:id])
    @friend = User.friendly.find(params[:id])
    @logged_in_user = current_user if signed_in?
    @report = Report.new
    if current_user.subscribed_access? || current_user == @user
      if current_user.image? || current_user == @user
        @events = Event.live_events.open_events
        @activities_user = PublicActivity::Activity.order("created_at desc").where(owner_id: @user)
      else
        redirect_to image_restriction_page_path
      end
    else
      redirect_to subscription_path(@premium_plan)
    end
    # allows current_user to only see their profile page and not other memebers if they do not have a profile image & if not subscribed
  end

  def edit
    unless current_user.admin_pa_management_group || current_user == @user
      redirect_to errorpermission_path
    end
  end

  def update
    if current_user.admin_pa_management_group || current_user == @user
      @user.update(user_params)
      redirect_to @user
    else
      redirect_to errorpermission_path
    end
  end

  def account
    if current_user.admin_pa_management_group || current_user == @user
      @user_payments = @user.payments.valid_payments.status_success.order("created_at desc")
      @user_subscription = @user.payments.valid_subscriptions.status_success.order("created_at desc")
    else
      redirect_to errorpermission_path
    end
  end

  def membership
    unless current_user.admin_pa_management_group || current_user == @user
      redirect_to errorpermission_path
    end
  end

  def settings
    unless current_user.admin_pa_management_group || current_user == @user
      redirect_to errorpermission_path
    end
  end

  def dashboard
    if current_user.admin_pa_management_group
      @users = User.all
      @socials = Social.all
      @events = Event.all
    else
      redirect_to errorpermission_path
    end
  end

  def analytics
    unless current_user.admin_pa_management_group
      redirect_to errorpermission_path
    end
  end

  def company
    if current_user.admin_pa_management_group
      @users = User.all
      @socials = Social.all
      @events = Event.all
      @payments = Payment.all
    else
      redirect_to errorpermission_path
    end
  end

  def stats_users
    if current_user.admin_pa_management_group
      @users = User.all
      @socials = Social.all
      @events = Event.all
      @payments = Payment.all
    else
      redirect_to errorpermission_path
    end
  end

  def stats_socials
    if current_user.admin_pa_management_group || current_user.pa_event_mgt_group
      @users = User.all
      @socials = Social.all
      @events = Event.all
      @payments = Payment.all
    else
      redirect_to errorpermission_path
    end
  end

  def groups
    if current_user.admin_pa_management_group
      @users = User.all
      @socials = Social.all
      @events = Event.all
      @payments = Payment.all
    else
      redirect_to errorpermission_path
    end 
  end

  def stats_events
    if current_user.admin_pa_management_group || current_user.pa_event_mgt_group
      @users = User.all
      @socials = Social.all
      @events = Event.all
      @payments = Payment.all
    else
      redirect_to errorpermission_path
    end
  end

  def transactions
    if current_user.admin_pa_management_group
      @users = User.all
      @socials = Social.all
      @events = Event.all
      @payments = Payment.all
    else
      redirect_to errorpermission_path
    end
  end

  def stats_blogs
    if current_user.admin_pa_management_group || current_user.pa_administration_group
      @users = User.all
      @socials = Social.all
      @events = Event.all
      @payments = Payment.all
    else
      redirect_to errorpermission_path
    end
  end

  def inquiries
    if current_user.admin_pa_management_group || current_user.pa_administration_group
      @users = User.all
      @socials = Social.all
      @events = Event.all
      @payments = Payment.all
    else
      redirect_to errorpermission_path
    end
  end

  def reports
    if current_user.admin_pa_management_group || current_user.pa_administration_group
      @users = User.all
      @socials = Social.all
      @events = Event.all
      @payments = Payment.all
    else
      redirect_to errorpermission_path
    end
  end

  def network
    if current_user.admin_pa_management_group || current_user == @user
      @search = current_user.friends.search(params[:q])
      @friends = @search.result(distinct: true)
    else
      redirect_to errorpermission_path
    end
  end

  def followings
    if current_user.admin_pa_management_group || current_user == @user
      @search = current_user.followings.search(params[:q])
      @followings = @search.result(distinct: true)
    else
      redirect_to errorpermission_path
    end
  end

  def followers
    if current_user.admin_pa_management_group || current_user == @user
      @search = current_user.followers.search(params[:q])
      @followers = @search.result(distinct: true)
    else
      redirect_to errorpermission_path
    end
  end

  def attending_socials
    unless current_user.admin_pa_management_group || current_user == @user
      redirect_to errorpermission_path
    end  
  end

  def attending_events 
    unless current_user.admin_pa_management_group || current_user == @user
      redirect_to errorpermission_path
    end 
  end

  def saved_socials 
    unless current_user.admin_pa_management_group || current_user == @user
      redirect_to errorpermission_path
    end 
  end

  def saved_events 
    unless current_user.admin_pa_management_group || current_user == @user
      redirect_to errorpermission_path
    end 
  end

  def live_socials 
    unless current_user.admin_pa_management_group || current_user == @user
      redirect_to errorpermission_path
    end 
  end

  def expired_socials 
    unless current_user.admin_pa_management_group || current_user == @user
      redirect_to errorpermission_path
    end 
  end

  private
  def setup_friends
    if action_name == 'edit'
      @user = User.friendly.find(params[:id])
      @friend = User.find_by_email(params[:id])
    else
      @user = User.find(current_user.id)
      @friend = User.find_by_email(params[:id])
    end
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

  def set_user
    @user = User.friendly.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :birthdate, :category_gender_id, :description, :profession, :image, :tag_list, :category_role_id, :category_managementgroup_id, :stripe_id, :stripe_subscription_pymt_id, :card_last4, :card_exp_month, :card_exp_year, :card_type, :recent_subscription_pymt_date, :stripe_event_pymt_id, :recent_event_pymt_date, :host_description, :slug, :category_inviteoption_id, :link_fb, :link_twitter, :category_country_id)
  end
end
