class AddAcceptedatToFriendships < ActiveRecord::Migration
  def change
    add_column :friendships, :accepted_at, :datetime
  end
end
