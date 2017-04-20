class Subscription < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_subscriptions, use: :slugged

  validates_presence_of :title, presence: true, message: "can't be blank"
  validates_presence_of :price, presence: true, message: "can't be blank"
  
  has_many :payments, dependent: :destroy
  
  before_create :generate_reference_number

  def slug_subscriptions
    [
      :title
    ]
  end

  def should_generate_new_friendly_id?
    slug.blank? || self.title_changed?
  end

  def generate_reference_number
    begin
      reference_length = 6
      self.reference = "SPz_" + Devise.friendly_token.first(reference_length)
    end while self.class.exists?(reference: reference)
  end
end
