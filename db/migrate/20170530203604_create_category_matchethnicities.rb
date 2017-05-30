class CreateCategoryMatchethnicities < ActiveRecord::Migration
  def change
    create_table :category_matchethnicities do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
