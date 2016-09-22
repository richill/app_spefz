class Social < ActiveRecord::Base
  acts_as_taggable
  
  belongs_to :user
  belongs_to :category_topic
  belongs_to :category_age
  belongs_to :category_country

  mount_uploader :image, ImageUploader
end
