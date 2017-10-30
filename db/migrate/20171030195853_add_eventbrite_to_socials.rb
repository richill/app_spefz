class AddEventbriteToSocials < ActiveRecord::Migration
  def change
    add_column :socials, :eventbrite, :boolean
    add_column :socials, :eventbrite_url, :text
  end
end
