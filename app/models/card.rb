class Card < ActiveRecord::Base
  acts_as_readable :on => :created_at
  
  belongs_to :event
  has_many :payments, through: :event

  scope :status_nil, -> {where(['status = ? OR status IS ?', false, nil])}
  scope :status_remove, -> {where(['status = ?', "remove"])}

  # scope :booked_events_with_cards, -> (user) { joins(event: :payments).where(users: { id: user.id }) }
  # scope :cards_with_booked_events, -> (user) { joins(payments: :event).where(users: { id: user.id }) }
  # scope :cards_with_events, -> () { joins(:event) }


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
