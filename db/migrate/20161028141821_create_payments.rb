class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :email
      t.integer :user_id
      t.integer :subscription_id
      t.string :reference

      t.timestamps null: false
    end
  end
end
