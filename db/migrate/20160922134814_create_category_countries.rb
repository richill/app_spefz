class CreateCategoryCountries < ActiveRecord::Migration
  def change
    create_table :category_countries do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
