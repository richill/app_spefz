class CreateCategoryMatchbodytypes < ActiveRecord::Migration
  def change
    create_table :category_matchbodytypes do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
