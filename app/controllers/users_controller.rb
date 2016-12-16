class UsersController < ApplicationController
  respond_to :html, :xml, :json
  before_action :set_user, only: [:show, :edit, :update, :destroy, :followings, :followers, :dashboard, :membership, :account, :settings]

  def index
    @premium_plan = Subscription.find_by(title:"premium")
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
    @premium_plan = Subscription.find_by(title:"premium")
    @logged_in_user = current_user if signed_in?
    if current_user.subscribed_access? || current_user == @user
      if current_user.image? || current_user == @user
        @events = Event.live_events.open_events
        @activities_user = PublicActivity::Activity.order("created_at desc").where(owner_id: @user)
      else
        redirect_to image_restriction_page_path
      end
    else
      @premium_plan = Subscription.find_by(title:"premium")
      redirect_to subscription_path(@premium_plan)
    end
    # allows current_user to only see their profile page and not other memebers if they do not have a profile image & if not subscribed
  end

  def edit
    @premium_plan = Subscription.find_by(title:"premium")
  end

  def update
    @user.update(user_params)
    redirect_to @user
  end

  def account
    @user_payments = @user.payments.valid_payments.status_success.order("created_at desc")
    @user_subscription = @user.payments.valid_subscriptions.status_success.order("created_at desc")
    @premium_plan = Subscription.find_by(title:"premium")
  end

  def membership
    @premium_plan = Subscription.find_by(title:"premium")
  end

  def settings
    @premium_plan = Subscription.find_by(title:"premium")
  end

  def dashboard
  end

  def analytics
  end

  def company
  end

  def stats_users
  end

  def stats_socials
  end

  def stats_events
  end

  def transactions
  end

  def stats_blogs
  end

  def inquiries
  end

  private
    def set_user
      @user = User.friendly.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :firstname, :lastname, :birthdate, :category_gender_id, :description, :profession, :image, :tag_list, :category_role_id, :category_managementgroup_id, :stripe_id, :stripe_subscription_pymt_id, :card_last4, :card_exp_month, :card_exp_year, :card_type, :recent_subscription_pymt_date, :stripe_event_pymt_id, :recent_event_pymt_date, :host_description, :slug)
    end
end
