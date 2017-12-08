class SocialsController < ApplicationController
  respond_to :html, :xml, :json
  before_action :authenticate_user!, :set_social, only: [:show, :edit, :update, :destroy]
  before_filter :setup_friends, :setup_subscription, :setup_cards, :setup_events, :setup_invite_form, :setup_user_network_activities
  impressionist :actions=>[:show]

  def index
    if params[:tag]
      @socials = Social.tagged_with(params[:tag]).live_socials.open_socials
      @search = Social.search(params[:q])
      @listed_socials = @search.result(distinct: true)
    else
      @search = Social.search(params[:q])
      @socials = @search.result(distinct: true).live_socials.open_socials
    end
    @report = Report.new
  end

  # def user_socials
  #   @user = User.friendly.find(params[:user_id])
  #   @socials = @user.socials.order("created_at DESC")
  #   respond_with(@socials)
  # end

  def show
    @social = Social.friendly.find(params[:id])
    impressionist(@social)
    @invite_request = InviteRequest.new
    unless current_user.subscribed_social_access?(@social)
      @premium_plan = Subscription.find_by(title:"premium")
      redirect_to subscription_path(@premium_plan)
    else
      @commentable = @social
      @comment = Comment.new
      @comments = @commentable.comments
    end
  end

  def new
    if current_user.subscribed_access?
      if current_user.image?
        @user = User.friendly.find(params[:user_id])
        @social = @user.socials.build
      else
        redirect_to image_restriction_page_path
      end
    else
      @premium_plan = Subscription.find_by(title:"premium")
      redirect_to subscription_path(@premium_plan)
    end
  end

  def edit
    unless @social.user.email == current_user.email
      redirect_to errorpermission_path
    end
    unless current_user.subscribed_social_access?(@social)
      @premium_plan = Subscription.find_by(title:"premium")
      redirect_to subscription_path(@premium_plan)
    end
  end

  def create
    if current_user.subscribed_access?
      @user = User.friendly.find(params[:user_id])
      @social = @user.socials.create(social_params)

      respond_to do |format|
        if @social.save
          format.html { redirect_to([@social.user, @social], notice: 'Social was successfully created.') }
          format.json  { render json: @social, status: :created, location: @social }
        else
          format.html { render action: "new" }
          format.json  { render json: @social.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to subscription_path(@premium_plan)
    end
  end

  def update
    if current_user.subscribed_social_access?(@social)
      respond_to do |format|
        if @social.update_attributes(social_params)
          format.html { redirect_to([@social.user, @social], notice: 'Social was successfully updated.') }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @social.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to subscription_path(@premium_plan)
    end
  end

  def destroy
    if current_user.admin_pa_management_group
      @user = User.friendly.find(params[:user_id])
      @social = @user.socials.find(params[:id])
      @social.destroy
      redirect_to socials_path
    else
      redirect_to errorpermission_path
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

  def social_params
    params.require(:social).permit(:title, :description, :address, :postcode, :latitude, :longitude, :user_id, :category_topic_id, :image, :date, :time, :city, :quantity, :category_age_id, :companyname, :category_country_id, :tag_list, :category_invite_id, :speakername, :speakerlinkedin, :venuename, :maplink, :close, :slug, :category_quantitygendersocial_id, :upcoming_social, :company_image, :eventbrite, :eventbrite_url, :social_image_link)
  end
end
