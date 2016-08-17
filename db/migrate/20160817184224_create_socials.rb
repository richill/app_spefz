class CreateSocials < ActiveRecord::Migration
  def change
    create_table :socials do |t|
      t.string :title
      t.text :description
      t.string :address
      t.string :postcode
      t.float :latitude
      t.float :longitude
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
