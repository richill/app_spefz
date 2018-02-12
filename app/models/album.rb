class Album < ActiveRecord::Base
  scope :published_albums, -> { where('publish = ?', true) }
  scope :unpublished_albums, -> { where('publish = ?', false) }
end
