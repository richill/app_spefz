class Blog < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_blogs, use: :slugged

  validates_presence_of :title, presence: true, message: "can't be blank"
  validates_presence_of :content, presence: true, message: "can't be blank"
  validates :content, length: { minimum: 100 }
  validates_presence_of :user_id, presence: true, message: "can't be blank"
  validates_presence_of :category_blog, presence: true, message: "please select a category"
  validates_presence_of :user_link, presence: true, message: "can't be blank"
  validates_presence_of :twitter_link, presence: true, message: "can't be blank"
  validate :image_or_blogimagelink_or_videolink

  mount_uploader :image, ImageUploader
  belongs_to :user
  belongs_to :category_blog

  scope :news, ->() { joins(:category_blog).where('category_blogs.name' => "News") }    
  scope :venues, ->() { joins(:category_blog).where('category_blogs.name' => "Venues") } 
  scope :networking, ->() { joins(:category_blog).where('category_blogs.name' => "Networking Tips") } 
  scope :dating, ->() { joins(:category_blog).where('category_blogs.name' => "Dating Tips") } 

  def slug_blogs
    [
      :title
    ]
  end

  def image_or_blogimagelink_or_videolink
    if image.blank? ^ blog_image_link.blank? ^ video_link.blank?
      errors.add(:image, "either upload an Image, paste an image link or video link")
      errors.add(:blog_image_link, "either upload an Image, paste an image link or video link")
      errors.add(:video_link, "either upload an Image, paste an image link or video link")
    end
  end
end
