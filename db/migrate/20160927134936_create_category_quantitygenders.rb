class CreateCategoryQuantitygenders < ActiveRecord::Migration
  def change
    create_table :category_quantitygenders do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
