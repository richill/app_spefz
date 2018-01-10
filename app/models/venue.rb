class Venue < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_venues, use: :slugged

  validates_presence_of :venuename, presence: true, message: "can't be blank"
  validates_presence_of :email, presence: true, message: "can't be blank"
  validates_presence_of :address, presence: true, message: "can't be blank"
  validates_presence_of :postcode, presence: true, message: "can't be blank"
  validates_presence_of :maplink, presence: true, message: "can't be blank"
  validates_presence_of :station, presence: true, message: "can't be blank"
  validates_presence_of :website, presence: true, message: "can't be blank"
  validates_presence_of :category_country, presence: true, message: "can't be blank"
  validates_presence_of :city, presence: true, message: "can't be blank"

  belongs_to :category_country

  def slug_venues
    [
      :venuename
    ]
  end

  def should_generate_new_friendly_id?
    slug.blank? || self.venuename_changed?
  end
end
