class Contact < ActiveRecord::Base
  belongs_to :category_enquiry
  belongs_to :category_contactclient

  before_create :generate_reference_number

  def generate_reference_number
    begin
      reference_length = 6
      self.reference = "SPz_" + Devise.friendly_token.first(reference_length)
    end while self.class.exists?(reference: reference)
  end
end
