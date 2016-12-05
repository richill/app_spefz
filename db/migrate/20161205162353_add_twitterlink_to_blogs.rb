class AddTwitterlinkToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :twitter_link, :string
  end
end
