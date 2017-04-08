class AddSubtitileToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :subtitle, :string
  end
end
