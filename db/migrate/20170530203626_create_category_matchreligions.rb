class CreateCategoryMatchreligions < ActiveRecord::Migration
  def change
    create_table :category_matchreligions do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
