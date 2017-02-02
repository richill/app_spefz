class BankcardsController < ApplicationController
  before_action :authenticate_user!

  def update
    begin
      customer = Stripe::Customer.retrieve(current_user.stripe_id)
      subscription = customer.subscriptions.retrieve(current_user.stripe_payment_id)
      subscription.plan = subscription.plan.id
      subscription.source = params[:stripeToken]
      subscription.save

      current_user.update(
        card_last4: params[:card_last4],
        card_exp_month: params[:card_exp_month],
        card_exp_year: params[:card_exp_year],
        card_type: params[:card_brand]
      )
      redirect_to membership_user(current_user), notice: "Card details was successfully updated"
    rescue Stripe::InvalidRequestError => e
      redirect_to membership_user(current_user), alert: "Card details are invalid"
      # redirect_to membership_user(current_user), alert: e.message
    end   
  end 
end
