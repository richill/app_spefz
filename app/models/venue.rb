class Venue < ActiveRecord::Base

  validates_presence_of :venuename, presence: true, message: "can't be blank"
  validates_presence_of :address, presence: true, message: "can't be blank"
  validates_presence_of :postcode, presence: true, message: "can't be blank"
  validates_presence_of :maplink, presence: true, message: "can't be blank"
  validates_presence_of :station, presence: true, message: "can't be blank"
  validates_presence_of :website, presence: true, message: "can't be blank"
  validates_presence_of :category_country, presence: true, message: "can't be blank"
  validates_presence_of :city, presence: true, message: "can't be blank"

  belongs_to :category_country
end
