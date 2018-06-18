class CreateCategoryAdverts < ActiveRecord::Migration
  def change
    create_table :category_adverts do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
