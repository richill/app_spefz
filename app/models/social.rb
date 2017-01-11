class Social < ActiveRecord::Base
  include PublicActivity::Model
  # tracked only: [:update, :create], owner: -> (controller, model) { controller && controller.current_user }
  tracked only: [:create], owner: -> (controller, model) { controller && controller.current_user }

  extend FriendlyId
  friendly_id :slug_socials, use: :slugged
  
  acts_as_taggable
  is_impressionable

  # acts_as_commentable
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :attendances, as: :attendable, dependent: :destroy
  has_many :reports
  has_many :invites
  
  belongs_to :user
  belongs_to :category_topic
  belongs_to :category_age
  belongs_to :category_country
  belongs_to :category_invite
  belongs_to :category_quantitygender

  mount_uploader :image, ImageUploader
  before_create :generate_reference_number

  geocoded_by :location                                    # can also be an IP address
  after_validation :geocode, if: :address_changed?         # auto-fetch coordinates

  scope :expired_socials, -> {where(['date < ?', Date.current])}

  scope :expired_or_closed_socials, -> {where('close = ? OR date < ?', true, Date.current)}

  scope :live_socials, -> {where(['date >= ?', Date.current])}

  scope :closed_socials, -> {where(close: true)}

  scope :open_socials, -> {where(['close = ? OR close IS ?', false, nil])}

  def slug_socials
    [
      :title
    ]
  end

  def original_url
    base_url + original_fullpath
  end


  def subscribed?
    self.user.stripe_subscription_pymt_id?
  end

  def expired_social
    self.date < Date.current
  end

  def live_social
    self.date >= Date.current
  end

  def open_social
    self.close == false || self.close == nil
  end

  def expired_or_closed_social
    self.date < Date.current || self.close == true
  end

  def location
    [address, city, category_country_id].compact.join(', ')
  end

  def generate_reference_number
    begin
      reference_length = 6
      self.reference = "SPz_" + Devise.friendly_token.first(reference_length)
    end while self.class.exists?(reference: reference)
  end

  #checks if current user is attending social
  def current_user_attending?(user)
    self.attendances.exists?(user: user)
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

  #remaining_space_female
  def available_female_places
    capacity = self.quantity
    female_attendance = self.attendances.female_attendance.count
    exception_for_male_attendance = self.attendances.male_attendance.count
    capacity - (female_attendance + exception_for_male_attendance)
  end

  def total_attendance_to_female_only_social
    female_attendance = self.attendances.female_attendance.count
    exception_for_male_attendance = self.attendances.male_attendance.count
    female_attendance + exception_for_male_attendance
  end

  #remaining_space_male
  def available_male_places
    capacity = self.quantity
    male_attendance = self.attendances.male_attendance.count
    exception_for_female_attendance = self.attendances.female_attendance.count
    capacity - (male_attendance + exception_for_female_attendance)
  end

  def total_attendance_to_male_only_social
    male_attendance = self.attendances.male_attendance.count
    exception_for_female_attendance = self.attendances.female_attendance.count
    male_attendance + exception_for_female_attendance
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

