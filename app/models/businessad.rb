class Businessad < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_businessads, use: :slugged

  validates_presence_of :name, presence: true, message: "can't be blank"
  validates_presence_of :content, presence: true, message: "can't be blank"
  validates_presence_of :link, presence: true, message: "can't be blank"
  validates_presence_of :category_advert, presence: true, message: "can't be blank"
  validates_presence_of :companyname, presence: true, message: "can't be blank"
  validates_presence_of :imagelink, presence: true, message: "can't be blank"
  validates_presence_of :publishdate_start, presence: true, message: "can't be blank"
  validates_presence_of :publishdate_end, presence: true, message: "can't be blank"
  validates_presence_of :price, presence: true, message: "can't be blank"
  validates_presence_of :clientname, presence: true, message: "can't be blank"
  validates_presence_of :clientjob, presence: true, message: "can't be blank"
  validates_presence_of :clientcontact, presence: true, message: "can't be blank"

  belongs_to :user
  belongs_to :event
  belongs_to :category_advert

  before_create :generate_reference_number

  scope :live_adverts, -> {where(['publishdate_end >= ?', Date.current])}

  scope :expired_adverts, -> {where(['publishdate_end < ?', Date.current])}

  scope :open_adverts, -> {where(['close = ? OR close IS ?', false, nil])} 

  scope :closed_adverts, -> {where(['close = ?', true])}

  scope :expired_closed_adverts, -> { where('close = ? OR publishdate_end < ?', true, Date.current) }

  scope :adverts, ->() { joins(:category_advert).where('category_adverts.name' => "Advert") } 
  scope :sponsorship, ->() { joins(:category_advert).where('category_adverts.name' => "Sponsorship") } 
  scope :partnership, ->() { joins(:category_advert).where('category_adverts.name' => "Partnership") } 

  scope :total_price, -> { sum("businessads.price") }

  scope :live_this_month, -> { where(publishdate_end: Time.now.beginning_of_month..Time.now.end_of_month) }
  #adevrts that are live in current month

  scope :live_this_year, -> { where(publishdate_end: Time.now.beginning_of_year..Time.now.end_of_year) }
  #adevrts that are live in current year

  def slug_businessads
    [
      :name
    ]
  end

  def generate_reference_number
    begin
      reference_length = 6
      self.reference = "SPz_" + Devise.friendly_token.first(reference_length)
    end while self.class.exists?(reference: reference)
  end

  def advert_period
    ((self.publishdate_end - self.publishdate_start) + 1).to_i
  end

  def advert_remaining_period
    (self.publishdate_end - Date.current).to_i
  end

  def expired
    self.publishdate_end < Date.current
  end

  def live
    self.publishdate_end >= Date.current
  end

  def closed
    self.close == true || self.close == nil
  end

  def open
    self.close == false || self.close == nil
  end
end
