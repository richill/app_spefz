class CreateCategoryMatchsmokes < ActiveRecord::Migration
  def change
    create_table :category_matchsmokes do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
