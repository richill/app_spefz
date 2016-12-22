class CreateCategoryReports < ActiveRecord::Migration
  def change
    create_table :category_reports do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
