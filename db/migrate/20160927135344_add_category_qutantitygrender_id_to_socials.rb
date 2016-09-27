class AddCategoryQutantitygrenderIdToSocials < ActiveRecord::Migration
  def change
    add_column :socials, :category_quantitygender_id, :integer
  end
end
