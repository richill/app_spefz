class Favourite < ActiveRecord::Base
  belongs_to :user
  belongs_to :favourited, polymorphic: true

  scope :favourited_socials, -> {where(favourited_type: 'Social')}
  scope :favourited_events, -> {where(favourited_type: 'Event')}
end
