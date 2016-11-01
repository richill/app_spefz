class CategoryTopic < ActiveRecord::Base
  has_many :socials
  has_many :events
  belongs_to :category_country
end
