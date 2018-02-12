class Album < ActiveRecord::Base
  has_many :photos
  scope :published_albums, -> { where('publish = ?', true) }
  scope :unpublished_albums, -> { where('publish = ?', false) }
end
