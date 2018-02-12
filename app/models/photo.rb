class Photo < ActiveRecord::Base
  validates_presence_of :name, presence: true, message: "can't be blank"
  validates_presence_of :description, presence: true, message: "can't be blank"
  validates_presence_of :album_id, presence: true, message: "please select a category"
  validate :image_or_photolink
  
  belongs_to :album

  scope :published_photos, -> { where('publish = ?', true) }
  scope :unpublished_photos, -> { where('publish = ?', false) }

  def image_or_photolink
    if image.blank? ^ photo_image_link.blank?
      errors.add(:image, "either upload an Image, paste an image link or video link")
      errors.add(:photo_image_link, "either upload an Image, paste an image link or video link")
    end
  end
end
