class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :title
      t.integer :event_id

      t.timestamps null: false
    end
  end
end
