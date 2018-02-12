class Album < ActiveRecord::Base
  has_many :photos
  belongs_to :user

  scope :published_albums, -> { where('publish = ?', true) }
  scope :unpublished_albums, -> { where('publish = ?', false) }
end
