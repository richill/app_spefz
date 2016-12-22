class RemoveDetailsFromFriendships < ActiveRecord::Migration
  def change
    remove_column :friendships, :friender_id, :integer
    remove_column :friendships, :friended_id, :integer
  end
end
