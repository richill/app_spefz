class CreateCategoryMatchheights < ActiveRecord::Migration
  def change
    create_table :category_matchheights do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
