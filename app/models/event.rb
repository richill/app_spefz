class Event < ActiveRecord::Base
  acts_as_taggable
  
  belongs_to :user
  belongs_to :category_topic
  belongs_to :category_age
  belongs_to :category_country
  belongs_to :category_quantitygender

  mount_uploader :image, ImageUploader

  geocoded_by :location                         # can also be an IP address
  after_validation :geocode, if: :address_changed?         # auto-fetch coordinates

  def location
    [address, city, category_country_id].compact.join(', ')
  end

  def google_map(center)
    "https://maps.googleapis.com/maps/api/staticmap?center=#{center}&size=300x300&zoom=17"
  end
end