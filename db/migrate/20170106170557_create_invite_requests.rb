class CreateInviteRequests < ActiveRecord::Migration
  def change
    create_table :invite_requests do |t|
      t.integer :user_id
      t.integer :inviter_id
      t.integer :social_id
      t.integer :event_id
      t.string :status

      t.timestamps null: false
    end
  end
end
