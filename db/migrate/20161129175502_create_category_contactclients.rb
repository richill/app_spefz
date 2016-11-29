class CreateCategoryContactclients < ActiveRecord::Migration
  def change
    create_table :category_contactclients do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
