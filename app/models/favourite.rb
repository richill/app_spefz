class Favourite < ActiveRecord::Base
  belongs_to :user
  belongs_to :favourited, polymorphic: true

  scope :favourited_socials, -> {where(favourited_type: 'Social')}
end
