class RemoveCategoryQuantitygenderIdFromSocials < ActiveRecord::Migration
  def change
    remove_column :socials, :category_quantitygender_id, :integer
  end
end
