class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  belongs_to :subscription

  before_create :generate_reference_number

  scope :by_females, -> { joins(user: :category_gender).where(category_genders: { name: 'Female' }) }
  scope :by_males, -> { joins(user: :category_gender).where(category_genders: { name: 'Male' }) }

  scope :payments, -> {where(['subscription_payment_date = ? OR subscription_payment_date IS ?', false, nil])}
  scope :subscriptions, -> {where(['event_payment_date = ? OR event_payment_date IS ?', false, nil])}
  scope :successful_payments, -> {where(['status = ?', "success"])}

  def generate_reference_number
    begin
      reference_length = 6
      self.reference = "SPz_" + Devise.friendly_token.first(reference_length)
    end while self.class.exists?(reference: reference)
  end
end
