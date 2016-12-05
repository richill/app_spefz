class AddLinksToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :user_image_link, :string
    add_column :blogs, :user_link, :string
    add_column :blogs, :blog_image_link, :string
  end
end
