class AddReferenceToSocials < ActiveRecord::Migration
  def change
    add_column :socials, :reference, :string
  end
end
