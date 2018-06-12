class Blog < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_blogs, use: :slugged
  is_impressionable

  validates_presence_of :title, presence: true, message: "can't be blank"
  validates_presence_of :content, presence: true, message: "can't be blank"
  validates :content, length: { minimum: 100 }
  validates_presence_of :user_id, presence: true, message: "can't be blank"
  validates_presence_of :category_blog, presence: true, message: "please select a category"
  validates_presence_of :user_link, presence: true, message: "can't be blank"
  validates_presence_of :twitter_link, presence: true, message: "can't be blank"
  validates_presence_of :publishdate, presence: true, message: "can't be blank"
  validate :image_or_blogimagelink_or_videolink

  mount_uploader :image, ImageUploader
  belongs_to :user
  belongs_to :category_blog

  scope :news, ->() { joins(:category_blog).where('category_blogs.name' => "News") }    
  scope :venues, ->() { joins(:category_blog).where('category_blogs.name' => "Venues") } 
  scope :networking, ->() { joins(:category_blog).where('category_blogs.name' => "Networking Tips") } 
  scope :dating, ->() { joins(:category_blog).where('category_blogs.name' => "Dating Tips") }

  scope :published_blogs, -> { where('publish = ?', true) }
  scope :unpublished_blogs, -> { where('publish = ?', false) }
  scope :unpublished_blogs_blank_or_null, -> () {where(["publish IS NULL or CAST(publish as text) = ''"])}
  scope :past_blogs, -> {where(['publishdate <= ?', Date.current])}

  scope :created_this_month, -> { where(created_at: Time.now.beginning_of_month..Time.now.end_of_month) }
  #blogs created in current month 

  scope :published_this_month, -> { where(publishdate: Time.now.beginning_of_month..Time.now.end_of_month) }
  #blogs published in current month 

  def slug_blogs
    [
      :title
    ]
  end

  def should_generate_new_friendly_id?
    slug.blank? || self.title_changed?
  end

  def image_or_blogimagelink_or_videolink
    if image.blank? ^ blog_image_link.blank? ^ video_link.blank?
      errors.add(:image, "either upload an Image, paste an image link or video link")
      errors.add(:blog_image_link, "either upload an Image, paste an image link or video link")
      errors.add(:video_link, "either upload an Image, paste an image link or video link")
    end
  end
end
