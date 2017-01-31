class AddCategoryCountryIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :category_country_id, :integer
  end
end
