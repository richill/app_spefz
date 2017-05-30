class CreateCategoryIdealeducations < ActiveRecord::Migration
  def change
    create_table :category_idealeducations do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
