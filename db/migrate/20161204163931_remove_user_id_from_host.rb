class RemoveUserIdFromHost < ActiveRecord::Migration
  def change
    remove_column :hosts, :user_id, :integer
  end
end
