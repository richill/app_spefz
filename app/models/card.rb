class Card < ActiveRecord::Base
  acts_as_readable :on => :created_at
  
  belongs_to :event
  has_many :payments, through: :event

  scope :status_nil, -> {where(['status = ? OR status IS ?', false, nil])}
  scope :status_remove, -> {where(['status = ?', "remove"])}

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
