class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :title
      t.decimal :price

      t.timestamps null: false
    end
  end
end
