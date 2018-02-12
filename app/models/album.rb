class Album < ActiveRecord::Base
  belongs_to :user
  has_many :photos, dependent: :destroy

  scope :published_albums, -> { where('publish = ?', true) }
  scope :unpublished_albums, -> { where('publish = ?', false) }
end
