class CreateHosts < ActiveRecord::Migration
  def change
    create_table :hosts do |t|
      t.integer :event_id

      t.timestamps null: false
    end
  end
end
