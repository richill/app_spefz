class Blog < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :user
  belongs_to :category_blog

  scope :news, ->() { joins(:category_blog).where('category_blogs.name' => "News") }    
  scope :venues, ->() { joins(:category_blog).where('category_blogs.name' => "Venues") } 
  scope :networking, ->() { joins(:category_blog).where('category_blogs.name' => "Networking Tips") } 
  scope :dating, ->() { joins(:category_blog).where('category_blogs.name' => "Dating Tips") } 
end
