class Social < ActiveRecord::Base
  belongs_to :user
  belongs_to :category_topic

  mount_uploader :image, ImageUploader
end
