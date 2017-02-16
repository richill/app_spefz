class CreateCategoryQuantitygendersocials < ActiveRecord::Migration
  def change
    create_table :category_quantitygendersocials do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
