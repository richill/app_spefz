class CreateCategoryAges < ActiveRecord::Migration
  def change
    create_table :category_ages do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
