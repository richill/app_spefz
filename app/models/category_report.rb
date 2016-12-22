class CategoryReport < ActiveRecord::Base
  has_many :events
  has_many :socials
  has_many :user
end
