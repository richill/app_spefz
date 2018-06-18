class CreateBusinessads < ActiveRecord::Migration
  def change
    create_table :businessads do |t|
      t.string :name
      t.text :content
      t.text :link
      t.string :image
      t.boolean :displaytext
      t.integer :category_advert_id
      t.integer :event_id

      t.timestamps null: false
    end
  end
end
