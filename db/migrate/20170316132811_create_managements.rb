class CreateManagements < ActiveRecord::Migration
  def change
    create_table :managements do |t|
      t.decimal :venuecost
      t.decimal :hostcost

      t.timestamps null: false
    end
  end
end
