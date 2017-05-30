class CreateCategoryMatchparents < ActiveRecord::Migration
  def change
    create_table :category_matchparents do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
