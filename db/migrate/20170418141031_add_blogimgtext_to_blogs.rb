class AddBlogimgtextToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :blogimgtxt_one, :string
    add_column :blogs, :blogimgtxt_two, :string
    add_column :blogs, :blogimgtxt_three, :string
  end
end
