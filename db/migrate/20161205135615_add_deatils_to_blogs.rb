class AddDeatilsToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :user_image_url, :string
    add_column :blogs, :user_url_link, :string
    add_column :blogs, :image_url_link, :string
  end
end
