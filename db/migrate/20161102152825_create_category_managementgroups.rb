class CreateCategoryManagementgroups < ActiveRecord::Migration
  def change
    create_table :category_managementgroups do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
