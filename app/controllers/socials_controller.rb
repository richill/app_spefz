class SocialsController < ApplicationController
  respond_to :html, :xml, :json
  before_action :set_social, only: [:show, :edit, :update, :destroy]
  impressionist :actions=>[:show]

  def index
    if params[:tag]
      @socials = Social.tagged_with(params[:tag])
      @search = Social.search(params[:q])
      @listed_socials = @search.result(distinct: true)
    else
      @search = Social.search(params[:q])
      @socials = @search.result(distinct: true)
    end
    @premium_plan = Subscription.find_by(title:"premium") 
  end

  def user_socials
    @user = User.find(params[:user_id])
    @socials = @user.socials.order("created_at DESC")
    respond_with(@socials)
  end

  def show 
    unless current_user.subscribed? || current_user.email == @social.user.email || current_user.admin_pa_management_group
      @premium_plan = Subscription.find_by(title:"premium")
      redirect_to subscription_path(@premium_plan)
    else
      @commentable = @social
      @comment = Comment.new
      @comments = @commentable.comments
    end
  end

  def new
    @user = User.find(params[:user_id])
    @social = @user.socials.build
  end

  def edit
    @user = User.find(params[:user_id])
  end

  def create
    @user = User.find(params[:user_id])
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
  end

  def update
    respond_to do |format|
      if @social.update_attributes(social_params)
        format.html { redirect_to([@social.user, @social], notice: 'Social was successfully updated.') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @social.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @social = @user.socials.find(params[:id])
    @social.destroy
    redirect_to socials_path
  end

  private
    def set_social
      @social = Social.find(params[:id])
    end

    def social_params
      params.require(:social).permit(:title, :description, :address, :postcode, :latitude, :longitude, :user_id, :category_topic_id, :image, :date, :time, :city, :quantity, :category_age_id, :companyname, :category_country_id, :tag_list, :category_invite_id, :speakername, :speakerlinkedin, :quantity_men, :quantity_women, :category_quantitygender_id, :venuename, :maplink)
    end
end
