class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.text :message
      t.integer :category_enquiry_id
      t.string :tel
      t.string :status
      t.string :reference
      t.integer :category_contactclient_id

      t.timestamps null: false
    end
  end
end
