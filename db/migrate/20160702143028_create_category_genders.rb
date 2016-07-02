class CreateCategoryGenders < ActiveRecord::Migration
  def change
    create_table :category_genders do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
