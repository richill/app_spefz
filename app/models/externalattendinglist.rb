class Externalattendinglist < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :event

  before_create :generate_reference_number

  def generate_reference_number
    begin
      reference_length = 6
      self.reference = "SPz_" + Devise.friendly_token.first(reference_length)
    end while self.class.exists?(reference: reference)
  end
end
