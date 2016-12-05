class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :content
      t.string :image
      t.integer :user_id
      t.integer :category_blog_id
      t.string :video_link

      t.timestamps null: false
    end
  end
end
