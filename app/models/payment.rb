class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  belongs_to :subscription

  before_create :generate_reference_number

  scope :by_females, -> { joins(user: :category_gender).where(category_genders: { name: 'Female' }) }
  scope :by_males, -> { joins(user: :category_gender).where(category_genders: { name: 'Male' }) }

  scope :valid_payments, -> {where(['subscription_payment_date = ? OR subscription_payment_date IS ?', false, nil])}
  scope :valid_subscriptions, -> {where(['event_payment_date = ? OR event_payment_date IS ?', false, nil])}
  scope :status_success, -> {where(['status = ?', "success"])}

  scope :events_with_successful_payments, -> {joins(:event).map(&:event).uniq}
  # payments.status_success.events_with_successful_payments
  # displays events with sucessful payments

  scope :events_with_successful_payments_prices, -> {joins(:event).map(&:event).map(&:price)}
  # payments.status_success.events_with_successful_payments_prices
  # displays prices of events with sucessful payments

  scope :sum_events_with_successful_payments_prices, -> {joins(:event).map(&:event).map(&:price).sum}
  # # payments.status_success.sum_events_with_successful_payments_prices
  # displays total sum of events with sucessful payments

  scope :created_this_month, -> { where(created_at: Time.now.beginning_of_month..Time.now.end_of_month) }

  def generate_reference_number
    begin
      reference_length = 6
      self.reference = "SPz_" + Devise.friendly_token.first(reference_length)
    end while self.class.exists?(reference: reference)
  end
end
