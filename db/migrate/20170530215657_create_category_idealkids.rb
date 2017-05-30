class CreateCategoryIdealkids < ActiveRecord::Migration
  def change
    create_table :category_idealkids do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
