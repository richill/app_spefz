class BlogsController < ApplicationController
  respond_to :html, :xml, :json
  before_action :set_blog, only: [:show, :edit, :update, :destroy]


  def index
    @premium_plan = Subscription.find_by(title:"premium")
    @search = Blog.order("created_at DESC").search(params[:q])
    @blogs = @search.result(distinct: true)
  end

  def show
    @premium_plan = Subscription.find_by(title:"premium")
    @search = Blog.order("created_at DESC").search(params[:q])
    @blogs = @search.result(distinct: true)
  end

  def new
    @premium_plan = Subscription.find_by(title:"premium")
    @user = User.friendly.find(params[:user_id])
    @blog = @user.blogs.build
  end

  def edit
    @premium_plan = Subscription.find_by(title:"premium")
    @user = User.friendly.find(params[:user_id])
  end

  def create
    @premium_plan = Subscription.find_by(title:"premium")
    @user = User.find(params[:user_id])
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
    @premium_plan = Subscription.find_by(title:"premium")
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
    @premium_plan = Subscription.find_by(title:"premium")
    @user = Userr.find(params[:user_id])
    @blog = @user.blogs.find(params[:id])
    @blog.destroy
    redirect_to blogs_path
  end

  def venues
    @premium_plan = Subscription.find_by(title:"premium")
    @search = Blog.order("created_at DESC").search(params[:q])
    @blogs = @search.result(distinct: true)
  end

  def networking_tips
    @premium_plan = Subscription.find_by(title:"premium")
    @search = Blog.order("created_at DESC").search(params[:q])
    @blogs = @search.result(distinct: true)
  end

  def dating_tips
    @premium_plan = Subscription.find_by(title:"premium")
    @search = Blog.order("created_at DESC").search(params[:q])
    @blogs = @search.result(distinct: true)
  end

  def spefz_news
    @premium_plan = Subscription.find_by(title:"premium")
    @search = Blog.order("created_at DESC").search(params[:q])
    @blogs = @search.result(distinct: true)
  end

  private
    def set_blog
      @blog = Blog.friendly.find(params[:id])
    end

    def blog_params
      params.require(:blog).permit(:title, :content, :image, :user_id, :category_blog_id, :video_link, :user_image_link, :user_link, :blog_image_link, :twitter_link, :slug)
    end
end
