class CreateJoinTableExternalattendinglistUser < ActiveRecord::Migration
  def change
    create_join_table :externalattendinglists, :users do |t|
      # t.index [:externalattendinglist_id, :user_id]
      # t.index [:user_id, :externalattendinglist_id]
    end
  end
end
