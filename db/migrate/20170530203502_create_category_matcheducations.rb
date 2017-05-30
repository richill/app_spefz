class CreateCategoryMatcheducations < ActiveRecord::Migration
  def change
    create_table :category_matcheducations do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
