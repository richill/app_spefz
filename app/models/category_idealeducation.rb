class CategoryIdealeducation < ActiveRecord::Base
  has_and_belongs_to_many :preferences
end
