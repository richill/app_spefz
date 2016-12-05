class CreateCategoryBlogs < ActiveRecord::Migration
  def change
    create_table :category_blogs do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
