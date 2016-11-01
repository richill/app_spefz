class CategoryTopic < ActiveRecord::Base
  has_many :socials
  has_many :events
  has_many :category_countries, through: :socials
  has_many :category_ages, through: :socials
end
