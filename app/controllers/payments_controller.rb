class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  def index
    @payments = Payment.all
  end

  def show
  end

  def new
    @payment = Payment.new
    @subscription_id = params[:subscription_id]
    @event_id = params[:event_id]
    if @subscription_id.present?
      @subscription = Subscription.find(params[:subscription_id])
    elsif @event_id.present?
      @event = Event.find(params[:event_id])
    end
  end

  def edit
  end

  def create
    @payment = Payment.new(payment_params)
    @subscription_id = @payment.subscription_id
    @event_id = @payment.event_id
    
    # ------- PAYMENT_SUBSCRIPTION -------
    # if @subscription_id.present?
      @user = current_user
      @payment = Payment.new(payment_params)
      @subscription = @payment.subscription_id
      @payment.user_id = current_user.id

      if current_user.stripe_id?
        customer = Stripe::Customer.retrieve(current_user.stripe_id)
      else
        customer = Stripe::Customer.create(email: current_user.email)
      end

      payment = customer.subscriptions.create(
        source: params[:stripeToken],
        plan: @subscription
        # the subscription.id is the database id
        # the plan.id in stripe uses the same id as that of the subscription.id in the database in order to select the right subsciption in stripe
      )

      current_user.update(
        stripe_id: customer.id,
        stripe_subscription_pymt_id: payment.id,
        card_last4: params[:card_last4],
        card_exp_month: params[:card_exp_month],
        card_exp_year: params[:card_exp_year],
        card_type: params[:card_brand],
        recent_subscription_pymt_date: DateTime.now
      )

      respond_to do |format|
        if @payment.save
          format.html { redirect_to dashboard_user_path(current_user), notice: 'Your Subscription Payment was successful.' }
          format.json { render :show, status: :created, location: @payment }
        else
          format.html { redirect_to new_payment_path(subscription_id: @subscription.id), alert: 'Ensure all fields are completed'}
          format.json { render json: @payment.errors, status: :unprocessable_entity }
        end
      end

    # ------- PAYMENT_EVENT -------
    # elsif @event_id.present?
    #   @user = current_user
    #   @payment = Payment.new(payment_params)
    #   @event = @payment.event
    #   @payment.user_id = current_user.id

    #   if current_user.stripe_id?
    #     customer = Stripe::Customer.retrieve(current_user.stripe_id)
    #   else
    #     customer = Stripe::Customer.create(email: current_user.email)
    #   end

    #   charge = Stripe::Charge.create(
    #     source: params[:stripeToken],
    #     amount: @event.price,
    #     description: @event.title,
    #     currency: 'gbp'
    #   )

    # current_user.update(
    #   stripe_id: customer.id,
    #   stripe_event_pymt_id: payment.id,
    #   card_last4: params[:card_last4],
    #   card_exp_month: params[:card_exp_month],
    #   card_exp_year: params[:card_exp_year],
    #   card_type: params[:card_brand],
    #   recent_event_pymt_date: DateTime.now
    # )

    #   respond_to do |format|
    #     if @payment.save
    #       format.html { redirect_to dashboard_user_path(current_user), notice: 'Your Booking Payment was successful.' }
    #       format.json { render :show, status: :created, location: @payment }
    #     else
    #       format.html { redirect_to new_payment_path(event_id: @event.id), alert: 'Ensure all fields are completed'}
    #       format.json { render json: @payment.errors, status: :unprocessable_entity }
    #     end
    #   end
    # end
  end

  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    #destroy here represents unsubscribe
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
    customer.subscriptions.retrieve(current_user.stripe_subscription_pymt_id).delete
    current_user.update(stripe_subscription_pymt_id: nil)
    current_user.update(recent_subscription_pymt_date: nil)

    redirect_to user_path(current_user), notice: "Payment Plan Successfully Cancelled"
    # @payment.destroy
    # respond_to do |format|
    #   format.html { redirect_to payments_url, notice: 'Payment was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:email, :user_id, :subscription_id, :reference, :event_id)
    end
end
