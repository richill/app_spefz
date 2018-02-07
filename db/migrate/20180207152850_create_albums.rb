class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name
      t.date :date
      t.text :description
      t.string :image

      t.timestamps null: false
    end
  end
end
