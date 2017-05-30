class CreateCategoryIdealsmokes < ActiveRecord::Migration
  def change
    create_table :category_idealsmokes do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
