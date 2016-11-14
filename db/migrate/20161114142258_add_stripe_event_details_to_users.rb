class AddStripeEventDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stripe_event_pymt_id, :string
    add_column :users, :recent_event_pymt_date, :datetime
  end
end
