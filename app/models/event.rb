class Event < ActiveRecord::Base
  include PublicActivity::Model
  tracked only: [:create], owner: -> (controller, model) { controller && controller.current_user }

  extend FriendlyId
  friendly_id :slug_events, use: :slugged

  ratyrate_rateable "atmosphere"
  
  acts_as_taggable
  is_impressionable

  validates_presence_of :title, presence: true, message: "can't be blank"
  validates_presence_of :description, presence: true, message: "can't be blank"
  validates_presence_of :address, presence: true, message: "can't be blank"
  validates_presence_of :postcode, presence: true, message: "can't be blank"
  validates_presence_of :user_id, presence: true, message: "can't be blank"
  validates_presence_of :category_topic, presence: true, message: "please select a category"
  validates_presence_of :date, presence: true, message: "please select a date"
  validates_presence_of :time, presence: true, message: "please select a time"
  validates_presence_of :city, presence: true, message: "can't be blank"
  # validates_presence_of :category_age, presence: true, message: "please select a category"
  validates_presence_of :category_country, presence: true, message: "please select a category"
  validates_presence_of :category_quantitygender, presence: true, message: "please select a category"
  validates_presence_of :venuename, presence: true, message: "can't be blank"
  validates_presence_of :price, presence: true, message: "can't be blank"
  validates_numericality_of :price, allow_nil: true
  validates_presence_of :time_end, presence: true, message: "can't be blank"
  validates_presence_of :maplink, presence: true, message: "can't be blank"
  # validates_numericality_of :event_score_access, allow_nil: true
  validates :event_score_access, numericality: { less_than: 5, greater_than_or_equal_to: 0, allow_nil: true }
  validates_presence_of :tag_list, presence: true, message: "can't be blank"
  validate :date_cannot_be_in_the_past
  validate :categoryage_or_agerange_info
  # validates :category_quantitygender_content
  # validates_numericality_of :quantity, presence: true, message: "can't be blank"
  # validates_numericality_of :quantity_men, presence: true, message: "can't be blank"
  # validates_numericality_of :quantity_women, presence: true, message: "can't be blank"
  validate :image_or_eventimagelink

  has_one :host, dependent: :destroy
  has_one :card, dependent: :destroy
  has_one :externalattendinglist, dependent: :destroy
  
  has_many :payments, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :managements
  has_many :businessads
  
  belongs_to :user
  belongs_to :category_topic
  belongs_to :category_age
  belongs_to :category_country
  belongs_to :category_quantitygender

  mount_uploader :image, ImageUploader
  before_create :generate_reference_number

  geocoded_by :location                               # can also be an IP address
  after_validation :geocode, if: :address_changed?    # auto-fetch coordinates

  # scope :events_access_below_user_score, -> (user) {where(['event_score_access <= ? OR event_score_access IS ? OR event_score_access IS ?', user.overall_ratings, nil, ""])}
  # #displays all events with event_score_access below user overall rating

  scope :events_access_below_user_score, -> (user) {where(['event_score_access <= ?', user.overall_ratings])}
  #displays all events with event_score_access below user overall rating

  scope :events_access_above_user_score, -> (user) {where(['event_score_access > ?', user.overall_ratings])}
  #displays all events with event_score_access above user overall rating

  scope :event_access_blank_or_null, -> () {where(["event_score_access IS NULL or CAST(event_score_access as text) = ''"])}
  #displays all events with event_score_access that nil or ""
  
  scope :expired_events, -> {where(['date < ?', Date.current])}

  scope :expired_or_closed_events, -> { where('close = ? OR date < ?', true, Date.current) }

  scope :live_events, -> {where(['date >= ?', Date.current])} 

  scope :closed_events, -> {where(['close = ?', true])}

  scope :non_upcoming_events, -> {where(['upcoming_event = ?', false])}

  scope :upcoming_events, -> {where(['upcoming_event = ?', true])}

  scope :open_events, -> {where(['close = ? OR close IS ?', false, nil])}

  scope :total_price_for_events, -> { joins(:payments).sum("events.price") }
  #sums the total payment amount for all open/live/expired events (by members that paid on spefz)
  #note: events.live_events.open_events.total_price_for_events.to_f.round(2) - focuses total sum for live&open

  scope :total_price_for_events_attendinglist, -> { joins(externalattendinglist: :users).sum("events.price") }
  #sums the total payment amount for all open/live/expired events (by members that paid on external platform)
  #note: events.live_events.open_events.total_price_for_events_attendinglist.to_f.round(2) - focuses total sum for live&open

  scope :booked_events, -> (user) { joins(payments: :user).where(users: { id: user.id }) }
  #terminal: events.booked_events(current_user)
  #displays all events that have been booked/paid by a user

  scope :booked_events_attendinglist, -> (user) { joins(externalattendinglist: :users).where(users: { id: user.id }) }
  # displays all events that have an attendingList of all users that includes current_user
  
  scope :unbooked_events, -> { includes(:payments).where(payments: { event_id: nil }) }
  #displays all events that have not been booked/paid by users | events that do not have payments [this can be used for Free & Paid Events]

  scope :booked_events_all, -> { includes(:payments).where.not(payments: { event_id: nil }) }
  #displays all events that have been booked/paid by users | events that do have payments

  scope :booked_events_all_total_price, -> { includes(:payments).where.not(payments: { event_id: nil }).sum("events.price") }
  #displays total price of all events that have been booked/paid by users | events that do have payments

  scope :booked_events_with_cards, -> (user) { joins(:card, payments: :user).where(users: { id: user.id }) }
  #displays all events with cards that have been booked/paid by a user

  scope :created_this_month, -> { where(created_at: Time.now.beginning_of_month..Time.now.end_of_month) }
  #event created in current month

  scope :held_this_month, -> { where(date: Time.now.beginning_of_month..Time.now.end_of_month) }
  #events held in current month (eg: could be created in 10.03.2014 held for current month)

  scope :events_with_no_ratings, -> { select {|event| event.overall_ratings == 0 }}
  # events_with_no_ratings = events.select {|event| event.overall_ratings == 0 }.count

  scope :events_with_ratings, -> { select {|event| event.overall_ratings > 0 }}
  # events_with_ratings = events.select {|event| event.overall_ratings > 0 }.count

  scope :paid_events, -> {where(['price > ?', 0])} 
  # paid_events: events with a price

  scope :free_events, -> {where(['price = ?', 0])} 
  # free_events: events without a price

  scope :free_events_with_externalattendinglist, -> { select {|event| event.externalattendinglist.present? && event.free_event }}

  scope :free_events_with_externalattendinglist_live_open, -> { select {|event| event.externalattendinglist.present? && event.free_event && event.live_event && event.open_event }}

  scope :paid_events_with_externalattendinglist, -> { select {|event| event.externalattendinglist.present? && event.paid_event }}

  scope :paid_events_with_externalattendinglist_live_open, -> { select {|event| event.externalattendinglist.present? && event.paid_event && event.live_event && event.open_event }}

  scope :events_with_cards, -> { select {|event| event.card.present? }}

  scope :events_without_cards, -> { select {|event| !event.card.present? }}

  scope :events_with_externalattendinglist, -> { select {|event| event.externalattendinglist.present? }}

  # events that have an externalattendinglist && that has no users
  # scope :events_with_externalattendinglist_nousers, -> { select {|event| event.externalattendinglist.users.empty? }}
  scope :events_with_externalattendinglist_nousers, -> { joins(:user).where(users: {id: nil}).joins(:externalattendinglist)}

  # events that have an externalattendinglist && that has users
  # scope :events_with_externalattendinglist_users, -> { select {|event| event.externalattendinglist.users.present? }}
  scope :events_with_externalattendinglist_users, -> { joins(:user).where(users: {id: !nil}).joins(:externalattendinglist)}

  scope :events_without_externalattendinglist, -> { select {|event| event.externalattendinglist.nil? }}

  scope :events_with_externalattendinglist_live_open, -> { select {|event| event.externalattendinglist.present? && event.live_event && event.open_event }}

  scope :events_with_cards_and_externalattendinglist, -> { select {|event| event.externalattendinglist.present? && event.card.present? }}

  def free_event
    self.price == 0
  end

  def paid_event
    self.price > 0
  end

  def location
    [address, city, category_country_id].compact.join(', ')
  end
  
  def event_with_payments_sum(event)
    self.payments.to_a.map(&:price).sum
  end

  def slug_events
    [
      :title
    ]
  end

  def should_generate_new_friendly_id?
    slug.blank? || self.title_changed?
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
    user_rating = user.overall_ratings                                        
    user_rating_percentage = (user_rating/5)*100                              
    event_access = self.event_score_access.to_f
    event_access_percentage = (event_access/5)*100
    match = (event_access_percentage/user_rating_percentage)*100 
    if match.is_a?(Float) && match.nan? || self.event_score_access.blank? || self.event_score_access <= 0
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

  # displays the overall average rating of all events that have been & have not been rated on the platform
  def self.overall_ratings_with_zero_ratings
    events = Event.all
    rating_sum = events.map(&:overall_ratings).sum
    rating_count = events.map(&:overall_ratings).count
    avg_score = rating_sum / (rating_count.nonzero? || 1)
    avg_score.round(1)
  end

  def self.overall_ratings_with_zero_ratings_count
    events = Event.all
    rating_count = events.map(&:overall_ratings).count
  end

  # displays the overall average rating of all events that have been rated on the platform
  def self.overall_ratings_without_zero_ratings
    events = Event.all
    all_ratings = events.map(&:overall_ratings)
    refined_ratings = all_ratings - [0]
    refined_ratings_sum = refined_ratings.sum
    refined_ratings_count = refined_ratings.count
    avg_score = refined_ratings_sum / (refined_ratings_count.nonzero? || 1)
    avg_score.round(1)
  end

  def self.overall_ratings_without_zero_ratings_count
    events = Event.all
    all_ratings = events.map(&:overall_ratings)
    refined_ratings = all_ratings - [0]
    refined_ratings_count = refined_ratings.count
  end

  #displays the overall avaerage rating for an event
  def overall_ratings
    array = Rate.where(rateable_id: id, rateable_type: 'Event')
    stars = array.map {|event| event.stars }
    star_count = stars.count
    stars_total = stars.inject(0){|sum,x| sum + x }
    score = stars_total / (star_count.nonzero? || 1)
  end

  #validations: events can not be created in the past
  def date_cannot_be_in_the_past
    if date.present? && date <= Date.today
      errors.add(:date, "event date can not be in the past")
    end
  end

  #validations
  # def category_quantitygender_content
  #   if category_quantitygender_id.present? && quantity.blank? || quantity_men.blank? || quantity_women.blank?
  #     errors.add(:quantity, "can't be blank")
  #     errors.add(:quantity_men, "can't be blank")
  #     errors.add(:quantity_women, "can't be blank")
  #   end
  # end
  
  #checks if current user has paid to attend event
  def current_user_attending_paid?(user)
    self.payments.exists?(user: user)
  end

  #checks if current user has paid via and external platform and been added to the externalAttendingList to attend event
  def current_user_attending_listed?(user)
    self.externalattendinglist.users.include?(user)
  end

  def user_on_event_attendingList?(user)
    if self.externalattendinglist.present?
      self.externalattendinglist.users.include?(user)
    end
  end

  def expired_event
    self.date < Date.current
  end

  def live_event
    self.date >= Date.current
  end

  def open_event
    self.close == false || self.close == nil
  end

  def expired_or_closed_event
    self.date < Date.current || self.close == true
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
    if self.externalattendinglist.present?
      attendance_list_males = self.externalattendinglist.users.males.count
      attendance_list_females = self.externalattendinglist.users.females.count
      attendance_males = self.payments.by_males.count + attendance_list_males
      attendance_females = self.payments.by_females.count + attendance_list_females
      attendance = attendance_males + attendance_females
    else
      attendance = self.payments.by_females.count + self.payments.by_males.count
    end
  end

  def attendance_Xmen
    if self.externalattendinglist.present?
      attendance_list_males = self.externalattendinglist.users.males.count
      attendance_males = self.payments.by_males.count
      attendance = attendance_males + attendance_list_males
    else
      attendance = self.payments.by_males.count
    end
  end

  def attendance_Xwomen
    if self.externalattendinglist.present?
      attendance_list_females = self.externalattendinglist.users.females.count
      attendance_females = self.payments.by_females.count
      attendance = attendance_females + attendance_list_females
    else
      attendance = self.payments.by_females.count
    end
  end


  #remaining_space [female + male] for selection: both_Xmen_and_Xwomen [selection_BothX_men_and_women]
  def total_available_places_BothX_men_and_women
    if self.externalattendinglist.present?
      # memebers that registered on external platforms like eventbrite who have been placed on the spefz attendingList
      attendance_list_males = self.externalattendinglist.users.males.count
      attendance_list_females = self.externalattendinglist.users.females.count
      attendance_males = self.payments.by_males.count + attendance_list_males
      attendance_females = self.payments.by_females.count + attendance_list_females
      attendance = attendance_males + attendance_females
      capacity   = self.quantity_women + self.quantity_men
      capacity - attendance
    else
      attendance = self.payments.by_females.count + self.payments.by_males.count
      capacity   = self.quantity_women +  self.quantity_men
      capacity - attendance
    end
  end

  #remaining_space [female] for selection: both_Xmen_and_Xwomen [selection_BothX_men_and_women]
  def available_places_Xwomen
    if self.externalattendinglist.present?
      # memebers that registered on external platforms like eventbrite who have been placed on the spefz attendingList
      attendance_list_females = self.externalattendinglist.users.females.count
      attendance_females = self.payments.by_females.count
      attendance = attendance_females + attendance_list_females
      capacity   = self.quantity_women
      capacity - attendance
    else
      attendance = self.payments.by_females.count
      capacity   = self.quantity_women
      capacity - attendance
    end 
  end

  #remaining_space [male] for selection: both_Xmen_and_Xwomen [selection_BothX_men_and_women]
  def available_places_Xmen
    if self.externalattendinglist.present?
      # memebers that registered on external platforms like eventbrite who have been placed on the spefz attendingList
      attendance_list_males = self.externalattendinglist.users.males.count
      attendance_males = self.payments.by_males.count
      attendance = attendance_males + attendance_list_males
      capacity   = self.quantity_men
      capacity - attendance
    else
      attendance = self.payments.by_males.count
      capacity   = self.quantity_men
      capacity - attendance 
    end
  end

  #remaining_space [female + women] for selection: both_men_and_women [selection_BothAndOnly_men_and_women]
  def total_available_places_BothAndOnly_men_and_women
    if self.externalattendinglist.present?
      # memebers that registered on external platforms like eventbrite who have been placed on the spefz attendingList
      attendance_list_males = self.externalattendinglist.users.males.count
      attendance_list_females = self.externalattendinglist.users.females.count
      attendance_males = self.payments.by_males.count + attendance_list_males
      attendance_females = self.payments.by_females.count + attendance_list_females
      attendance = attendance_males + attendance_females
      capacity   = self.quantity 
      capacity - attendance 
    else
      attendance = self.payments.by_females.count + self.payments.by_males.count 
      capacity   = self.quantity 
      capacity - attendance 
    end
  end

  def total_available_places_Only_men
    if self.externalattendinglist.present?
      # memebers that registered on external platforms like eventbrite who have been placed on the spefz attendingList
      attendance_list_males = self.externalattendinglist.users.males.count
      attendance_males = self.payments.by_males.count
      attendance = attendance_males + attendance_list_males
      capacity   = self.quantity 
      capacity - attendance 
    else
      attendance = self.payments.by_males.count 
      capacity   = self.quantity 
      capacity - attendance 
    end
  end

  def total_available_places_Only_women
    if self.externalattendinglist.present?
      # memebers that registered on external platforms like eventbrite who have been placed on the spefz attendingList
      attendance_list_females = self.externalattendinglist.users.females.count
      attendance_females = self.payments.by_females.count
      attendance = attendance_females + attendance_list_females
      capacity   = self.quantity 
      capacity - attendance 
    else
      attendance = self.payments.by_females.count
      capacity   = self.quantity 
      capacity - attendance 
    end
  end
 
  #remaining_space [female] for selection: only_women [selection_BothAndOnly_men_and_women]
  def available_places_women
    if self.externalattendinglist.present?
      # memebers that registered on external platforms like eventbrite who have been placed on the spefz attendingList
      attendance_list_females = self.externalattendinglist.users.females.count
      attendance_females = self.payments.by_females.count
      attendance = attendance_females + attendance_list_females
      capacity   = self.quantity 
      capacity - attendance
    else
      attendance = self.payments.by_females.count
      capacity   = self.quantity
      capacity - attendance
    end
  end

  #remaining_space [male] for selection: only_men [selection_BothAndOnly_men_and_women]
  def available_places_men
    if self.externalattendinglist.present?
      # memebers that registered on external platforms like eventbrite who have been placed on the spefz attendingList
      attendance_list_males = self.externalattendinglist.users.males.count
      attendance_males = self.payments.by_males.count
      attendance = attendance_males + attendance_list_males
      capacity   = self.quantity 
      capacity - attendance
    else
      attendance = self.payments.by_males.count                                    
      capacity   = self.quantity                                                  
      capacity - attendance 
    end                                                    
  end

  #attendance [female + women] for selection: both_men_and_women [selection_BothAndOnly_men_and_women]
  def total_attendance_BothAndOnly_men_and_women
    if self.category_quantitygender.name == "only men"
      if self.externalattendinglist.present?
        attendance_list_males = self.externalattendinglist.users.males.count
        attendance_males = self.payments.by_males.count
        attendance = attendance_males + attendance_list_males
      else
        attendance = self.payments.by_males.count
      end
    elsif self.category_quantitygender.name == "only women"
      if self.externalattendinglist.present?
        attendance_list_females = self.externalattendinglist.users.females.count
        attendance_females = self.payments.by_females.count 
        attendance = attendance_females + attendance_list_females
      else
        attendance = self.payments.by_females.count
      end
    elsif self.category_quantitygender.name == "both men & women" || self.selection_BothX_men_and_women 
      if self.externalattendinglist.present?
        attendance_list_males = self.externalattendinglist.users.males.count
        attendance_list_females = self.externalattendinglist.users.females.count
        attendance_males = self.payments.by_males.count + attendance_list_males
        attendance_females = self.payments.by_females.count + attendance_list_females
        attendance = attendance_males + attendance_females
      else
        attendance = self.payments.by_males.count + self.payments.by_females.count
      end
    end
  end

  def total_attendance_display
    if self.category_quantitygender.name == "only men"
     self.payments.by_males
    elsif self.category_quantitygender.name == "only women"
      self.payments.by_females
    elsif self.category_quantitygender.name == "both men & women" || self.selection_BothX_men_and_women 
      self.payments
    end
  end

  def total_listed_attendance_display
    if self.externalattendinglist.present?
      if self.category_quantitygender.name == "only men"
        self.externalattendinglist.users.males
      elsif self.category_quantitygender.name == "only women"
        self.externalattendinglist.users.females
      elsif self.category_quantitygender.name == "both men & women" || self.selection_BothX_men_and_women 
        self.externalattendinglist.users
      end
    end
  end

  def sold_out?
    self.category_quantitygender.name == "only men" && (self.total_available_places_Only_men <= 0) ||
    self.category_quantitygender.name == "only women" && (self.total_available_places_Only_women <= 0) ||
    self.category_quantitygender.name == "both men & women" && (self.total_available_places_BothAndOnly_men_and_women <= 0) ||
    self.selection_BothX_men_and_women && self.total_available_places_BothX_men_and_women <= 0 
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
  
  def categoryage_or_agerange_info
    if category_age_id.blank? && agerange_info.blank?
      errors.add(:base, "Specify or select age range, not both")
    end
  end

  def venue_imgs?
    self.imgvenue_one? || self.imgvenue_two? || self.imgvenue_three?
  end

  def event_imgs?
    self.imgevent_one? || self.imgevent_two? || self.imgevent_three? || self.imgevent_four? || self.imgevent_five? || self.imgevent_six?
  end

  def event_price_zero?
    self.price == 0 || self.price == 0.00
  end

  def event_with_zero_access
    event_score_access == 0 || event_score_access == nil
  end

  def image_or_eventimagelink
    if image.blank? && event_image_link.blank?
      errors.add(:image, "must upload an image")
      errors.add(:event_image_link, "either upload an Image or paste an image link")
    end
  end

  #displays the number of events users is attending (which they have registered on external platform)
  def user_test(user)
    #find only events with external attending list
    events = Event.all
    self.externalattendinglist.users(user).count
  end

  #displays total count & amount made from created paid_events
  def self.count_total_paid_events 
    paid_events.count
  end

  def self.total_paid_events_amt
    paid_events_spefz = paid_events.total_price_for_events.to_f.round(2)
    paid_events_externalattendinglist = paid_events.total_price_for_events_attendinglist.to_f.round(2)
    total_paid_events = paid_events_spefz + paid_events_externalattendinglist
  end

  #displays total count & amount made from created free_events
  def self.count_total_free_events  
    free_events.count
  end

  def self.total_free_events_amt
    free_events_spefz = free_events.total_price_for_events.to_f.round(2)
    free_events_externalattendinglist = free_events.total_price_for_events_attendinglist.to_f.round(2)
    total_free_events = free_events_spefz + free_events_externalattendinglist
  end


  #displays total count & amount made from created active paid_events
  def self.count_total_active_paid_events 
    paid_events.live_events.open_events.count
  end

  def self.total_active_paid_events_amt
    paid_events_live_open_spefz = paid_events.live_events.open_events.total_price_for_events.to_f.round(2)
    paid_events_live_open_externalattendinglist = paid_events.live_events.open_events.total_price_for_events_attendinglist.to_f.round(2)
    total_paid_active_events = paid_events_live_open_spefz + paid_events_live_open_externalattendinglist
  end


  #displays total count & amount made from created active free_events
  def self.count_total_active_free_events 
    free_events.live_events.open_events.count
  end

  def self.total_active_free_events_amt
    free_events_live_open_spefz = free_events.live_events.open_events.total_price_for_events.to_f.round(2)
    free_events_live_open_externalattendinglist = free_events.live_events.open_events.total_price_for_events_attendinglist.to_f.round(2)
    total_free_active_events = free_events_live_open_spefz + free_events_live_open_externalattendinglist
  end

  #displays total count & amount made from created active paid_events being held in current month
  def self.count_total_active_paid_events_heldThisMonth 
    paid_events.held_this_month.live_events.open_events.count
  end

  def self.total_active_paid_events_heldThisMonth_amt
    paid_events_live_open_heldThisMonth_spefz = paid_events.held_this_month.live_events.open_events.total_price_for_events.to_f.round(2)
    paid_events_live_open_heldThisMonth_externalattendinglist = paid_events.held_this_month.live_events.open_events.total_price_for_events_attendinglist.to_f.round(2)
    total_paid_active_events_heldThisMonth = paid_events_live_open_heldThisMonth_spefz + paid_events_live_open_heldThisMonth_externalattendinglist
  end

  #displays total count & amount made from created active free_events being held in current month
  def self.count_total_active_free_events_heldThisMonth 
    free_events.held_this_month.live_events.open_events.count
  end

  def self.total_active_free_events_heldThisMonth_amt
    free_events_live_open_heldThisMonth_spefz = free_events.held_this_month.live_events.open_events.total_price_for_events.to_f.round(2)
    free_events_live_open_heldThisMonth_externalattendinglist = free_events.held_this_month.live_events.open_events.total_price_for_events_attendinglist.to_f.round(2)
    total_free_active_events_heldThisMonth = free_events_live_open_heldThisMonth_spefz + free_events_live_open_heldThisMonth_externalattendinglist
  end

  #displays total count & amount made from created closed_expired paid_events
  def self.count_total_closed_paid_events 
    paid_events.expired_or_closed_events.count
  end

  def self.total_closed_paid_events_amt
    paid_events_closed_or_expired_spefz = paid_events.expired_or_closed_events.total_price_for_events.to_f.round(2)
    paid_events_closed_or_expired_externalattendinglist = paid_events.expired_or_closed_events.total_price_for_events_attendinglist.to_f.round(2)
    total_closed_paid_events = paid_events_closed_or_expired_spefz + paid_events_closed_or_expired_externalattendinglist
  end

  #displays total count & amount made from created closed_expired free_events
  def self.count_total_closed_free_events 
    free_events.expired_or_closed_events.count
  end

  def self.total_closed_free_events_amt
    free_events_closed_or_expired_spefz = free_events.expired_or_closed_events.total_price_for_events.to_f.round(2)
    free_events_closed_or_expired_externalattendinglist = free_events.expired_or_closed_events.total_price_for_events_attendinglist.to_f.round(2)
    total_closed_free_events = free_events_closed_or_expired_spefz + free_events_closed_or_expired_externalattendinglist
  end

  #displays total count of created active paid_events
  def self.count_unbooked_active_paid_events 
    paid_events.unbooked_events.live_events.open_events.count
  end

  #displays total count of created active free_events
  def self.count_unbooked_active_free_events  
    free_events.unbooked_events.live_events.open_events.count
  end

  #displays events with only payments and no created attendingList
  def self.event_with_only_payments
    booked_events_all.live_events.open_events.events_without_externalattendinglist
  end

  #displays events with only a created attedingList with users & no payments
  def self.event_with_only_attendinglist_users
    #if self.externalattendinglist.users.present?
      unbooked_events.live_events.open_events.events_with_externalattendinglist
    #end
  end

  #displays events with payments and a created attendingList with no users
  def self.event_with_payments_and_attendinglist_nousers
      booked_events_all.live_events.open_events.events_with_externalattendinglist_nousers
  end

  #displays events with payments and a created attendingList with users
  def self.event_with_payments_and_attendinglist_users
    booked_events_all.live_events.open_events.events_with_externalattendinglist_users
  end

  #displays events [held in current month] with only payments and no created attendingList
  def self.event_with_only_payments_heldThisMonth
    held_this_month.booked_events_all.live_events.open_events.events_without_externalattendinglist
  end

  #displays events [held in current month] with only a created attedingList with users & no payments
  def self.event_with_only_attendinglist_users_heldThisMonth
    held_this_month.unbooked_events.live_events.open_events.events_with_externalattendinglist
  end

  #displays events [held in current month] with payments and a created attendingList with no users
  def self.event_with_payments_and_attendinglist_nousers_heldThisMonth
    held_this_month.booked_events_all.live_events.open_events.events_with_externalattendinglist_nousers
  end

  #displays events [held in current month] with payments and a created attendingList with users
  def self.event_with_payments_and_attendinglist_users_heldThisMonth
    held_this_month.booked_events_all.live_events.open_events.events_with_externalattendinglist_users
  end
end






