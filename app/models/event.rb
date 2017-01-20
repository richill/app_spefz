class Event < ActiveRecord::Base
  include PublicActivity::Model
  tracked only: [:create], owner: -> (controller, model) { controller && controller.current_user }

  extend FriendlyId
  friendly_id :slug_events, use: :slugged

  ratyrate_rateable "atmosphere"
  
  acts_as_taggable

  # validate :date_cannot_be_in_the_past

  has_one :host
  has_one :card
  
  has_many :payments 
  has_many :reports
  
  belongs_to :user
  belongs_to :category_topic
  belongs_to :category_age
  belongs_to :category_country
  belongs_to :category_quantitygender

  mount_uploader :image, ImageUploader
  before_create :generate_reference_number

  geocoded_by :location                               # can also be an IP address
  after_validation :geocode, if: :address_changed?    # auto-fetch coordinates

  scope :events_access_below_user_score, -> (user) {where(['event_score_access <= ? OR event_score_access IS ? OR event_score_access IS ?', user.overall_ratings, nil, ""])}
  #displays all events with event_score_access above user overall rating

  scope :events_access_above_user_score, -> (user) {where(['event_score_access > ?', user.overall_ratings])}
  #displays all events with event_score_access below user overall rating

  scope :event_access_blank_or_null, -> () {where(["event_score_access IS NULL or CAST(event_score_access as text) = ''"])}
  #displays all events with event_score_access that nil or ""
  
  scope :expired_events, -> {where(['date < ?', Date.current])}

  scope :expired_or_closed_events, -> { where('close = ? OR date < ?', true, Date.current) }

  scope :live_events, -> {where(['date >= ?', Date.current])}

  scope :closed_events, -> {where(['close = ?', true])}

  scope :open_events, -> {where(['close = ? OR close IS ?', false, nil])}

  scope :booked_events, -> (user) { joins(payments: :user).where(users: { id: user.id }) }
  #terminal: events.booked_events(current_user)
  #displays all events that have been booked/paid by a user

  scope :booked_events_with_cards, -> (user) { joins(:card, payments: :user).where(users: { id: user.id }) }
  #displays all events with cards that have been booked/paid by a user

  # scope :live_or_open_events, -> {where(close = 'f' OR close IS NULL) AND (date >= '2016-11-19')}

  scope :created_this_month, -> { where(created_at: Time.now.beginning_of_month..Time.now.end_of_month) }


  def slug_events
    [
      :title
    ]
  end

  def display_event_match?
    self.display_match == true
  end

  def event_access_below_user_score(user)
    self.event_score_access.to_f.round(1) <= user.overall_ratings
  end

  def match(user)
    # user_rating:  3  | user_rating_percentage:  (user_rating/5)*100:  60%
    # event_access: 2  | event_access_percentage: (event_access/5)*100: 50%
    # match: (event_access_percentage/user_rating_percentage)*100:      83.3%
    # match.round(0) = 83%
    if self.event_score_access.blank?
      if self.event_score_access.blank?
        event_access = self.event_score_access = user.overall_ratings
      end
    end
    user_rating = user.overall_ratings
    user_rating_percentage = (user_rating/5)*100
    event_access = self.event_score_access.to_f
    event_access_percentage = (event_access/5)*100
    match = (event_access_percentage/user_rating_percentage)*100 
    if match.is_a?(Float) && match.nan?
      100
      #displays 100% if user has no ratings & event_access_is_blank_or_null
    else
      match_result = match.round(0)
    end
  end

  def generate_reference_number
    begin
      reference_length = 6
      self.reference = "SPz_" + Devise.friendly_token.first(reference_length)
    end while self.class.exists?(reference: reference)
  end

  #displays the overall avaerage rating for an event
  def overall_ratings
    array = Rate.where(rateable_id: id, rateable_type: 'Event')
    stars = array.map {|event| event.stars }
    star_count = stars.count
    stars_total = stars.inject(0){|sum,x| sum + x }
    score = stars_total / (star_count.nonzero? || 1)
  end

  #events can not be created in the past
  def date_cannot_be_in_the_past
    if date.present? && date <= Date.today
      errors.add(:date, "event date can not be in the past")
    end
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

  def expired_or_closed_event
    self.date < Date.current || self.close == true
  end

  def location
    [address, city, category_country_id].compact.join(', ')
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






