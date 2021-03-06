class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  before_filter :setup_friends, :setup_subscription, :setup_cards, :setup_events, :setup_invite_form, :setup_user_network_activities

  def index
    if current_user.admin_pa_management_group || current_user.pa_administration_group
      @contacts = Contact.all
    else
      redirect_to errorpermission_path
    end
  end

  def show
    unless current_user.admin_pa_management_group || current_user.pa_administration_group
      redirect_to errorpermission_path
    end
  end

  def new
    @premium_plan = Subscription.find_by(title:"premium")
    @contact = Contact.new
  end

  def edit
    unless current_user.admin_pa_management_group || current_user.pa_administration_group
      redirect_to errorpermission_path
    end
  end

  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        MailerContactus.contactus(@contact).deliver
        format.html { redirect_to message_delivered_path, notice: 'Message sent' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if current_user.admin_pa_management_group || current_user.pa_administration_group
      respond_to do |format|
        if @contact.update(contact_params)
          format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
          format.json { render :show, status: :ok, location: @contact }
        else
          format.html { render :edit }
          format.json { render json: @contact.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to errorpermission_path
    end
  end

  def destroy
    if current_user.admin_pa_management_group
      @contact.destroy
      respond_to do |format| 
        format.html { redirect_to inquiries_user_path(current_user), notice: 'Successfully deleted.' }
        format.json { head :no_content }
      end
    else
      redirect_to errorpermission_path
    end
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
    @invite = Invite.new
  end

  def setup_user_network_activities
    if signed_in?
      @user_network_activities = Activity.order("created_at desc").where(owner_id: current_user.friends)
      @activity =  Activity.last
    end
  end
  
  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:email, :message, :category_enquiry_id, :tel, :status, :reference, :category_contactclient_id, :lastname, :companyname, :firstname)
  end
end
