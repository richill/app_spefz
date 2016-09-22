class AddCategoryAgeIdToSocials < ActiveRecord::Migration
  def change
    add_column :socials, :category_age_id, :integer
  end
end
