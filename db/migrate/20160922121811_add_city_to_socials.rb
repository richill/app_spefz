class AddCityToSocials < ActiveRecord::Migration
  def change
    add_column :socials, :city, :string
  end
end
