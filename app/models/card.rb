class Card < ActiveRecord::Base
  belongs_to :event

  def self.desc_order
    order('date DESC')
  end
end
