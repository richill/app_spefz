class AddCategoryGenderIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :category_gender_id, :integer
  end
end
