class CreateCategoryIdealbodytypes < ActiveRecord::Migration
  def change
    create_table :category_idealbodytypes do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
