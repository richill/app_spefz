class CategoryQuantitygender < ActiveRecord::Base
  has_many :socials
  has_many :events
end
