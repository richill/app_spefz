class CreateJoinTableHostUser < ActiveRecord::Migration
  def change
    create_join_table :hosts, :users do |t|
      # t.index [:host_id, :user_id]
      # t.index [:user_id, :host_id]
    end
  end
end
