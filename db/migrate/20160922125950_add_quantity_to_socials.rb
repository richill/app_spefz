class AddQuantityToSocials < ActiveRecord::Migration
  def change
    add_column :socials, :quantity, :integer
  end
end
