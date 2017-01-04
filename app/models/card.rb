class Card < ActiveRecord::Base
  belongs_to :event

  scope :status_open, -> {where(['status = ? OR status IS ?', false, nil])}
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
end
