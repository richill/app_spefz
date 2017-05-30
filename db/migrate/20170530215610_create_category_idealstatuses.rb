class CreateCategoryIdealstatuses < ActiveRecord::Migration
  def change
    create_table :category_idealstatuses do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
