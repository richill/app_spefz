class Event < ActiveRecord::Base
  include PublicActivity::Model
  tracked only: [:create], owner: -> (controller, model) { controller && controller.current_user }
  
  acts_as_taggable

  has_many :payments
  
  belongs_to :user
  belongs_to :category_topic
  belongs_to :category_age
  belongs_to :category_country
  belongs_to :category_quantitygender

  mount_uploader :image, ImageUploader
  before_create :generate_reference_number

  geocoded_by :location                               # can also be an IP address
  after_validation :geocode, if: :address_changed?    # auto-fetch coordinates

  scope :expired_events, -> {where(['date < ?', Date.current])}

  scope :expired_or_closed_events, -> {where(['close = ?', true] || ['date < ?', Date.current])}

  scope :live_events, -> {where(['date >= ?', Date.current])}

  scope :closed_events, -> {where(['close = ? OR close IS ?', true])}

  scope :open_events, -> {where(['close = ? OR close IS ?', false, nil])}

  def generate_reference_number
    begin
      reference_length = 6
      self.reference = "SPz_" + Devise.friendly_token.first(reference_length)
    end while self.class.exists?(reference: reference)
  end

  #checks if current user had paid to attend event
  def current_user_attending?(user)
    self.payments.exists?(user: user)
  end

  def expired_event
    self.date < Date.current
  end

  def live_event
    self.date >= Date.current
  end

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