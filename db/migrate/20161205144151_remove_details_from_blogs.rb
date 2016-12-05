class RemoveDetailsFromBlogs < ActiveRecord::Migration
  def change
    remove_column :blogs, :user_image_url, :string
    remove_column :blogs, :user_url_link, :string
    remove_column :blogs, :image_url_link, :string
  end
end
