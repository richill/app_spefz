class CategoryTopic < ActiveRecord::Base
  has_many :socials
  has_many :events
  has_many :category_countries, through: :socials
end
