class BlogsController < ApplicationController
  respond_to :html, :xml, :json
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_filter :setup_friends, :setup_subscription, :setup_cards, :setup_events, :setup_invite_form, :setup_user_network_activities

  def index
    @search = Blog.published_blogs.past_blogs.order("publishdate DESC").search(params[:q])
    @blogs = @search.result(distinct: true)
  end

  def show
    @search = Blog.order("publishdate DESC").search(params[:q])
    @blogs = @search.result(distinct: true)
  end

  def new
    @user = User.friendly.find(params[:user_id])
    if current_user.admin_pa_management_group || current_user.pa_administration_group
      @blog = @user.blogs.build
    else
      redirect_to errorpermission_path
    end
  end

  def edit
    @user = User.friendly.find(params[:user_id])
    unless current_user.admin_pa_management_group || current_user.pa_administration_group
      redirect_to errorpermission_path
    end
  end

  def create
    @user = User.friendly.find(params[:user_id])
    if current_user.admin_pa_management_group || current_user.pa_administration_group
      @blog = @user.blogs.create(blog_params)
      respond_to do |format|
        if @blog.save
          format.html { redirect_to([@blog.user, @blog], notice: 'Blog was successfully created.') }
          format.json  { render json: @blog, status: :created, location: @blog }
        else
          format.html { render action: "new" }
          format.json  { render json: @blog.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to errorpermission_path
    end
  end

  def update
    if current_user.admin_pa_management_group || current_user.pa_administration_group
      respond_to do |format|
        if @blog.update_attributes(blog_params)
          format.html { redirect_to([@blog.user, @blog], notice: 'Blog was successfully updated.') }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @blog.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to errorpermission_path
    end
  end

  def destroy
    if current_user.admin_pa_management_group || current_user.pa_administration_group
      @user = User.friendly.find(params[:user_id])
      @blog = @user.blogs.find(params[:id])
      @blog.destroy
      redirect_to blogs_path
    else
      redirect_to errorpermission_path
    end
  end

  def venues
    @search = Blog.order("created_at DESC").search(params[:q])
    @blogs = @search.result(distinct: true)
  end

  def networking_tips
    @search = Blog.order("created_at DESC").search(params[:q])
    @blogs = @search.result(distinct: true)
  end

  def dating_tips
    @search = Blog.order("created_at DESC").search(params[:q])
    @blogs = @search.result(distinct: true)
  end

  def spefz_news
    @search = Blog.order("created_at DESC").search(params[:q])
    @blogs = @search.result(distinct: true)
  end

  private
  def setup_friends
    if signed_in?
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
    if signed_in?
      @invite = Invite.new
    end
  end

  def setup_user_network_activities
    if signed_in?
      @user_network_activities = Activity.order("created_at desc").where(owner_id: current_user.friends)
      @activity =  Activity.last
    end
  end

  def set_blog
    @blog = Blog.friendly.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:title, :content, :image, :user_id, :category_blog_id, :video_link, :user_image_link, :user_link, :blog_image_link, :twitter_link, :slug, :blogger_name, :publish, :publishdate, :subtitle, :blogimg_one, :blogimg_two, :blogimg_three)
  end
end
