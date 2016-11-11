class Event < ActiveRecord::Base
  include PublicActivity::Model
  tracked only: [:create], owner: -> (controller, model) { controller && controller.current_user }
  
  acts_as_taggable
  
  belongs_to :user
  belongs_to :category_topic
  belongs_to :category_age
  belongs_to :category_country
  belongs_to :category_quantitygender

  mount_uploader :image, ImageUploader

  geocoded_by :location                               # can also be an IP address
  after_validation :geocode, if: :address_changed?    # auto-fetch coordinates

  scope :expired_events, -> {where(['date < ?', Date.current])}

  scope :live_events, -> {where(['date >= ?', Date.current])}

  scope :closed_events, -> {where(close: true)}

  scope :open_events, -> {where(['close = ? OR close IS ?', false, nil])}

  def location
    [address, city, category_country_id].compact.join(', ')
  end

  def google_map(center)
    "https://maps.googleapis.com/maps/api/staticmap?center=#{center}&size=300x300&zoom=17"
  end

  def self.desc_order
    order('date DESC')
  end

  def self.asc_order
    order('date ASC')
  end
end