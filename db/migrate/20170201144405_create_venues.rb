class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :venuename
      t.string :address
      t.string :postcode
      t.text :maplink
      t.string :station
      t.decimal :price
      t.string :min_capacity
      t.string :eventmanager
      t.string :contact
      t.string :image

      t.timestamps null: false
    end
  end
end
