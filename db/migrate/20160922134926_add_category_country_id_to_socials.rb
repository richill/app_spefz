class AddCategoryCountryIdToSocials < ActiveRecord::Migration
  def change
    add_column :socials, :category_country_id, :integer
  end
end
