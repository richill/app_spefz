class Photo < ActiveRecord::Base
  belongs_to :album

  scope :published_photos, -> { where('publish = ?', true) }
  scope :unpublished_photos, -> { where('publish = ?', false) }
end
