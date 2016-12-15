class AddSlugToSocials < ActiveRecord::Migration
  def change
    add_column :socials, :slug, :string
    add_index :socials, :slug, unique: true
  end
end
