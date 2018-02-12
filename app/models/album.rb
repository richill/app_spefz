class Album < ActiveRecord::Base
  validates_presence_of :name, presence: true, message: "can't be blank"
  validates_presence_of :date, presence: true, message: "can't be blank"
  validates_presence_of :description, presence: true, message: "can't be blank"
  validate :image_or_albumlink

  belongs_to :user
  has_many :photos, dependent: :destroy

  scope :published_albums, -> { where('publish = ?', true) }
  scope :unpublished_albums, -> { where('publish = ?', false) }


  def image_or_albumlink
    if image.blank? ^ album_image_link.blank?
      errors.add(:image, "either upload an Image, paste an image link or video link")
      errors.add(:album_image_link, "either upload an Image, paste an image link or video link")
    end
  end
end
