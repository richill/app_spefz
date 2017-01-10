class CreateJoinTableInviteUser < ActiveRecord::Migration
  def change
    create_join_table :invites, :users do |t|
      # t.index [:invite_id, :user_id]
      # t.index [:user_id, :invite_id]
    end
  end
end
