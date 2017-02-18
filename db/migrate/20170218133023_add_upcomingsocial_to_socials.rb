class AddUpcomingsocialToSocials < ActiveRecord::Migration
  def change
    add_column :socials, :upcoming_social, :boolean
  end
end
