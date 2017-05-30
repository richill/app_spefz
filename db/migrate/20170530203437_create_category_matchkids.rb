class CreateCategoryMatchkids < ActiveRecord::Migration
  def change
    create_table :category_matchkids do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
