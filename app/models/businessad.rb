class Businessad < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_businessads, use: :slugged

  belongs_to :user
  belongs_to :event
  belongs_to :category_advert

  before_create :generate_reference_number

  def slug_businessads
    [
      :name
    ]
  end

  def generate_reference_number
    begin
      reference_length = 6
      self.reference = "SPz_" + Devise.friendly_token.first(reference_length)
    end while self.class.exists?(reference: reference)
  end

  def advert_period
    ((self.publishdate_end - self.publishdate_start) + 1).to_i
  end

  def expired_advert
    self.publishdate_end < Date.current
  end
end
