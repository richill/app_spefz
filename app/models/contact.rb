class Contact < ActiveRecord::Base
  validates_presence_of :firstname, presence: true, message: "can't be blank"
  validates_presence_of :lastname, presence: true, message: "can't be blank"
  validates_presence_of :firstname, presence: true, message: "can't be blank"
  validates_presence_of :email, presence: true, message: "can't be blank"
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "can't be blank or invalid format" }
  validates_presence_of :message, presence: true, message: "can't be blank"
  validates_presence_of :category_enquiry, presence: true, message: "please select a category"
  validates_presence_of :category_contactclient, presence: true, message: "please select a category"

  belongs_to :category_enquiry
  belongs_to :category_contactclient

  before_create :generate_reference_number

  scope :inquiry_resolved, -> {where(status: 'Resolved')}
  scope :inquiry_unresolved, -> {where(status: ['Unresolved', nil])}
  scope :general_enquiry, ->() { joins(:category_enquiry).where('category_enquirys.name' => "General Enquiry") }    
  scope :technical_support, ->() { joins(:category_enquiry).where('category_enquirys.name' => "Technical Support") } 
  scope :partnership, ->() { joins(:category_enquiry).where('category_enquirys.name' => "Partnership") } 
  scope :suggestions, ->() { joins(:category_enquiry).where('category_enquirys.name' => "Suggestions") }
  scope :compliants, ->() { joins(:category_enquiry).where('category_enquirys.name' => "Compliants") }    
  scope :feedback, ->() { joins(:category_enquiry).where('category_enquirys.name' => "Feedback") } 
  scope :creating_social, ->() { joins(:category_enquiry).where('category_enquirys.name' => "Creating a Social") } 
  scope :booking_event, ->() { joins(:category_enquiry).where('category_enquirys.name' => "Booking an Event") } 
  scope :marketing, ->() { joins(:category_enquiry).where('category_enquirys.name' => "Marketing") }
  scope :affiliates, ->() { joins(:category_enquiry).where('category_enquirys.name' => "Affiliates") }
  scope :advertising_on_spefz, ->() { joins(:category_enquiry).where('category_enquirys.name' => "Advertising on Spefz") }
  scope :suggest_partnership, ->() { joins(:category_enquiry).where('category_enquirys.name' => "Suggest a Partnership") }
  scope :customer_service, ->() { joins(:category_enquiry).where('category_enquirys.name' => "Customer Service") }
  scope :end_subscription, ->() { joins(:category_enquiry).where('category_enquirys.name' => "End Subscription Plan") }
  scope :delete_account, ->() { joins(:category_enquiry).where('category_enquirys.name' => "Delete Account") }
  scope :work_with_spefz, ->() { joins(:category_enquiry).where('category_enquirys.name' => "I would love to work at Spefz") }

  def generate_reference_number
    begin
      reference_length = 6
      self.reference = "SPz_" + Devise.friendly_token.first(reference_length)
    end while self.class.exists?(reference: reference)
  end
end
