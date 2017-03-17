class AddEventidToManagements < ActiveRecord::Migration
  def change
    add_column :managements, :event_id, :integer
  end
end
