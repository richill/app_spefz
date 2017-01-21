class AddBloggernameToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :blogger_name, :string
  end
end
