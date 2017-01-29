class Subscription < ActiveRecord::Base
  validates_presence_of :title, presence: true, message: "can't be blank"
  validates_presence_of :price, presence: true, message: "can't be blank"
  
  has_many :payments
  
  before_create :generate_reference_number

  def generate_reference_number
    begin
      reference_length = 6
      self.reference = "SPz_" + Devise.friendly_token.first(reference_length)
    end while self.class.exists?(reference: reference)
  end
end
