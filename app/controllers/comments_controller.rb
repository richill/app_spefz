class CommentsController < ApplicationController
  before_action :authenticate_user!, :set_comment, only: [:show, :edit, :update, :destroy]
  before_filter :load_commentable, :setup_subscription

  def index
    if current_user.admin_pa_management_group
      @comments = @commentable.comments
    else
      redirect_to errorpermission_path
    end
  end

  def show
    unless current_user.admin_pa_management_group
      redirect_to errorpermission_path
    end
  end

  def new
    if current_user.admin_pa_management_group
      @comment = @commentable.comments.new
    else
      redirect_to errorpermission_path
    end
  end

  def edit
    unless current_user.admin_pa_management_group
      redirect_to errorpermission_path
    end
  end

  def create
    if current_user.subscribed_access?
      @comment = @commentable.comments.new(comment_params)
      @comment.user = current_user
      @social = Social.friendly.find(params[:social_id])

      respond_to do |format|
        if @comment.save
          format.html { redirect_to [@commentable], notice: 'Comment was successfully posted.' }
          format.json { render :show, status: :created, location: @comment }
        else
          format.html { redirect_to :back, alert: 'Comment was not posted.' }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to subscription_path(@premium_plan)
    end
  end

  def update
    if current_user.admin_pa_management_group
      respond_to do |format|
        if @comment.update(comment_params)
          format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
          format.json { render :show, status: :ok, location: @comment }
        else
          format.html { render :edit }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to errorpermission_path
    end
  end

  def destroy
    if current_user.admin_pa_management_group
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to [@commentable], notice: 'Comment was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to errorpermission_path
    end
  end

  private
  def setup_subscription
    @premium_plan = Subscription.find_by(title:"premium") 
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :user_id)
  end

  def load_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.friendly.find(id)
  end
end
