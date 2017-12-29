class Card < ActiveRecord::Base
  acts_as_readable :on => :created_at

  extend FriendlyId
  friendly_id :slug_cards, use: :slugged

  validates_presence_of :title, presence: true, message: "can't be blank"
  validates_presence_of :event_id, presence: true, message: "can't be blank"
  
  belongs_to :event
  has_many :payments, through: :event
  has_many :externalattendinglists, through: :event

  scope :cards_with_booked_events, -> (user) { joins(:event, payments: :user).where(users: { id: user.id }) }
  # terminal: cards.cards_with_booked_events(current_user)
  # displays all cards with events that have been booked/paid by user | needed association "has_many :payments, through: :event" to work

  scope :cards_with_attendinglist_events, -> (user) { joins(:event, externalattendinglists: :users).where(users: { id: user.id }) }
  # displays all cards with events that have an attendingList of all users that includes current_user

  def slug_cards
    [
      :title
    ]
  end

  def self.desc_order
    order('created_at DESC')
  end

  def self.asc_order
    order('created_at ASC')
  end

  def card_status_open?
    Date.today > self.event.date 
  end

  def card_status_remove
    self.status == "remove"
  end

  def card_status_nil
    self.status == false || self.status == nil
  end
end
