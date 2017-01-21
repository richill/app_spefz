class BlogsController < ApplicationController
  respond_to :html, :xml, :json
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_filter :setup_subscription, :setup_cards, :setup_events, :setup_invite_form, :setup_user_network_activities


  def index
    @search = Blog.order("created_at DESC").search(params[:q])
    @blogs = @search.result(distinct: true)
  end

  def show
    @search = Blog.order("created_at DESC").search(params[:q])
    @blogs = @search.result(distinct: true)
  end

  def new
    @user = User.friendly.find(params[:user_id])
    @blog = @user.blogs.build
  end

  def edit
    @user = User.friendly.find(params[:user_id])
  end

  def create
    @user = User.friendly.find(params[:user_id])
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
  end

  def update
    respond_to do |format|
      if @blog.update_attributes(blog_params)
        format.html { redirect_to([@blog.user, @blog], notice: 'Blog was successfully updated.') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.friendly.find(params[:user_id])
    @blog = @user.blogs.find(params[:id])
    @blog.destroy
    redirect_to blogs_path
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
  end

  def set_blog
    @blog = Blog.friendly.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:title, :content, :image, :user_id, :category_blog_id, :video_link, :user_image_link, :user_link, :blog_image_link, :twitter_link, :slug, :blogger_name)
  end
end
