class AddCategoryQuantitygendersocialIdToSocials < ActiveRecord::Migration
  def change
    add_column :socials, :category_quantitygendersocial_id, :integer
  end
end
