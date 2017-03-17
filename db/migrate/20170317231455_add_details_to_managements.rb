class AddDetailsToManagements < ActiveRecord::Migration
  def change
    add_column :managements, :monthyear, :string
    add_column :managements, :week, :string
  end
end
