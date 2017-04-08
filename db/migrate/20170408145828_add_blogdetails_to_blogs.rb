class AddBlogdetailsToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :publish, :boolean
    add_column :blogs, :publishdate, :date
  end
end
