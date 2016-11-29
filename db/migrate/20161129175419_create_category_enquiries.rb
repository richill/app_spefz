class CreateCategoryEnquiries < ActiveRecord::Migration
  def change
    create_table :category_enquiries do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
