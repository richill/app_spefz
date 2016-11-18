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

  #checks if current user has paid to attend event
  def current_user_attending_paid?(user)
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

  #selection
  def selection_BothAndOnly_men_and_women
    self.category_quantitygender.name == "only men" || self.category_quantitygender.name == "only women" || self.category_quantitygender.name == "both men & women"
  end

  def selection_BothX_men_and_women
    self.category_quantitygender.name == "both X men & X women"
  end

  #attendance [female + male] for selection: both_Xmen_and_Xwomen [selection_BothX_men_and_women]
  def total_attendance_BothX_men_and_women
    attendance = self.payments.by_females.count + self.payments.by_males.count
  end

  def attendance_Xmen
    attendance = self.payments.by_males.count
  end

  def attendance_Xwomen
    attendance = self.payments.by_females.count
  end

  #remaining_space [female + male] for selection: both_Xmen_and_Xwomen [selection_BothX_men_and_women]
  def total_available_places_BothX_men_and_women
    attendance = self.payments.by_females.count + self.payments.by_males.count
    capacity   = self.quantity_women +  self.quantity_men
    capacity - attendance
  end

  #remaining_space [female] for selection: both_Xmen_and_Xwomen [selection_BothX_men_and_women]
  def available_places_Xwomen
    attendance = self.payments.by_females.count
    capacity   = self.quantity_women
    capacity - attendance
  end

  #remaining_space [male] for selection: both_Xmen_and_Xwomen [selection_BothX_men_and_women]
  def available_places_Xmen
    attendance = self.payments.by_males.count
    capacity   = self.quantity_men
    capacity - attendance 
  end

  #remaining_space [female + women] for selection: both_men_and_women [selection_BothAndOnly_men_and_women]
  def total_available_places_BothAndOnly_men_and_women
    attendance = self.payments.by_females.count + self.payments.by_males.count 
    capacity   = self.quantity 
    capacity - attendance 
  end

  #remaining_space [female] for selection: only_women [selection_BothAndOnly_men_and_women]
  def available_places_women
    attendance = self.payments.by_females.count
    capacity   = self.quantity
    capacity - attendance
  end

  #remaining_space [male] for selection: only_men [selection_BothAndOnly_men_and_women]
  def available_places_men
    attendance = self.payments.by_males.count                                    
    capacity   = self.quantity                                                  
    capacity - attendance                                                        
  end

  #attendance [female + women] for selection: both_men_and_women [selection_BothAndOnly_men_and_women]
  def total_attendance_BothAndOnly_men_and_women
    attendance = self.payments.by_females.count + self.payments.by_males.count
  end

  def sold_out?
    self.selection_BothX_men_and_women && self.total_available_places_BothX_men_and_women <= 0 ||
    self.selection_BothAndOnly_men_and_women && self.total_available_places_BothAndOnly_men_and_women <= 0
  end

  def sold_out_Xmen?
    self.available_places_Xmen <= 0
  end

  def sold_out_Xwomen?
    self.available_places_Xwomen <= 0
  end

  #only_male        | quantity
  #only_women       | quantity
  #both_male_women  | quantity
  #Xmale_Xwomen     | quantiy_men & quantity_women
end






