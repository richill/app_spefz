class Social < ActiveRecord::Base
  acts_as_taggable
  is_impressionable
  # acts_as_commentable

  # acts_as_commentable
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :attendances, as: :attendable, dependent: :destroy
  
  belongs_to :user
  belongs_to :category_topic
  belongs_to :category_age
  belongs_to :category_country
  belongs_to :category_invite
  belongs_to :category_quantitygender

  mount_uploader :image, ImageUploader

  geocoded_by :location                                    # can also be an IP address
  after_validation :geocode, if: :address_changed?         # auto-fetch coordinates

  scope :expired_socials, -> {where(['date < ?', Date.current])}

  scope :live_socials, -> {where(['date >= ?', Date.current])}

  def location
    [address, city, category_country_id].compact.join(', ')
  end

  #selection
  def selection_BothAndOnly_men_and_women
    self.category_quantitygender.name == "only men" || self.category_quantitygender.name == "only women" || self.category_quantitygender.name == "both men & women"
  end

  def selection_BothX_men_and_women
    self.category_quantitygender.name == "both X men & X women"
  end

  #remaining_space
  def available_places_BothAndOnly_men_and_women
    attendance = self.attendances.count
    capacity = self.quantity
    capacity - attendance
  end

  def available_places_BothX_men_and_women
    attendance = self.attendances.count #0
    capacity = self.quantity_men + self.quantity_women
    capacity - attendance
  end

  #set_space
  def set_availability_BothAndOnly_men_and_women
    self.quantity
  end

  def set_availability_BothX_men_and_women
    men = self.quantity_men
    women = self.quantity_women
    men + women
  end

  def sold_out?
    self.selection_BothAndOnly_men_and_women && self.available_places_BothAndOnly_men_and_women <= 0 || self.selection_BothX_men_and_women && self.available_places_BothX_men_and_women <= 0
  end

  def self.desc_order
    order('date DESC')
  end

  def self.asc_order
    order('date ASC')
  end
end

