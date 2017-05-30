class CreateCategoryMatchseekings < ActiveRecord::Migration
  def change
    create_table :category_matchseekings do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
