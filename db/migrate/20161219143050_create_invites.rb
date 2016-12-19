class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.integer :user_id
      t.integer :invitee_id
      t.integer :social_id
      t.integer :event_id

      t.timestamps null: false
    end
  end
end
