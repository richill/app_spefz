class AddDateToManagements < ActiveRecord::Migration
  def change
    add_column :managements, :date, :date
  end
end
