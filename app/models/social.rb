class Social < ActiveRecord::Base
  acts_as_taggable
  is_impressionable
  # acts_as_commentable

  # acts_as_commentable
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :attendances, as: :attendable, dependent: :destroy
  
  belongs_to :user
  belongs_to :category_topic
  belongs_to :category_age
  belongs_to :category_country
  belongs_to :category_invite

  mount_uploader :image, ImageUploader
end

