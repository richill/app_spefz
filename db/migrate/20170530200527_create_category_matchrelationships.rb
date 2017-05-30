class CreateCategoryMatchrelationships < ActiveRecord::Migration
  def change
    create_table :category_matchrelationships do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
