class AddImageToSocials < ActiveRecord::Migration
  def change
    add_column :socials, :image, :string
  end
end
