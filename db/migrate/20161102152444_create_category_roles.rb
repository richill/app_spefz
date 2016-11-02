class CreateCategoryRoles < ActiveRecord::Migration
  def change
    create_table :category_roles do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
