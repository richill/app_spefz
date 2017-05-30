class CreateCategoryIdealparents < ActiveRecord::Migration
  def change
    create_table :category_idealparents do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
