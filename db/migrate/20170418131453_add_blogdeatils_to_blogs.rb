class AddBlogdeatilsToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :blogimg_one, :string
    add_column :blogs, :blogimg_two, :string
    add_column :blogs, :blogimg_three, :string
  end
end
