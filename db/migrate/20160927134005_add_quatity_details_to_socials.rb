class AddQuatityDetailsToSocials < ActiveRecord::Migration
  def change
    add_column :socials, :quantity_men, :integer
    add_column :socials, :quantity_women, :integer
  end
end
