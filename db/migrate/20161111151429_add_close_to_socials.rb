class AddCloseToSocials < ActiveRecord::Migration
  def change
    add_column :socials, :close, :boolean
  end
end
