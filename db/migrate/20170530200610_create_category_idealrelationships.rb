class CreateCategoryIdealrelationships < ActiveRecord::Migration
  def change
    create_table :category_idealrelationships do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
