class AddMapLinkToSocials < ActiveRecord::Migration
  def change
    add_column :socials, :maplink, :text
  end
end
