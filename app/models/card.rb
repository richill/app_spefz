class Card < ActiveRecord::Base
  belongs_to :event

  def self.desc_order
    order('created_at DESC')
  end

  def self.asc_order
    order('created_at ASC')
  end
end
