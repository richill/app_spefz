class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :category_topic
  belongs_to :category_age
  belongs_to :category_country
  belongs_to :category_quantitygender

  mount_uploader :image, ImageUploader
end
