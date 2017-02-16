class RemoveDetailsFromSocials < ActiveRecord::Migration
  def change
    remove_column :socials, :quantity_men, :integer
    remove_column :socials, :quantity_women, :integer
  end
end
