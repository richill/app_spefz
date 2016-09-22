class Social < ActiveRecord::Base
  acts_as_taggable
  
  belongs_to :user
  belongs_to :category_topic
  belongs_to :category_age
  belongs_to :category_country
  belongs_to :category_invite

  mount_uploader :image, ImageUploader
end
