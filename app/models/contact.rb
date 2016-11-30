class Contact < ActiveRecord::Base
  validates_presence_of :firstname, presence: true, message: "can't be blank"
  validates_presence_of :lastname, presence: true, message: "can't be blank"
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "can't be blank or invalid format" }
  validates_presence_of :message, presence: true, message: "can't be blank"
  validates_presence_of :category_enquiry, presence: true, message: "please select a category"
  validates_presence_of :category_contactclient, presence: true, message: "please select a category"

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
