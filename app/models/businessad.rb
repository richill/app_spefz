class Businessad < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  belongs_to :category_advert
end
