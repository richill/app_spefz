class AddVenueNameToSocials < ActiveRecord::Migration
  def change
    add_column :socials, :venuename, :string
  end
end
