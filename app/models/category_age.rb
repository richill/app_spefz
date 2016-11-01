class CategoryAge < ActiveRecord::Base
  has_many :socials
  has_many :events
  has_many :category_topics, through: :socials
end
