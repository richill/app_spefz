class Report < ActiveRecord::Base
  validates_presence_of :content, presence: true, message: "can't be blank"
  validates_presence_of :category_report, presence: true, message: "please select a category"
  belongs_to :category_report
  belongs_to :social
  belongs_to :event
  belongs_to :user
  belongs_to :reporter, class_name: "User", foreign_key: "reporter_id"

  before_create :generate_reference_number

  def generate_reference_number
    begin
      reference_length = 6
      self.reference = "SPz_" + Devise.friendly_token.first(reference_length)
    end while self.class.exists?(reference: reference)
  end
end
