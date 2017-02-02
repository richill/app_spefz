class AddCanceldateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :recent_subscription_cancel_date, :datetime
  end
end
