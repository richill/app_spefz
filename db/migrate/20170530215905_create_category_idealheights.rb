class CreateCategoryIdealheights < ActiveRecord::Migration
  def change
    create_table :category_idealheights do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
