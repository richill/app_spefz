class AddStripeDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stripe_id, :string
    add_column :users, :stripe_subscription_pymt_id, :string
    add_column :users, :card_last4, :string
    add_column :users, :card_exp_month, :integer
    add_column :users, :card_exp_year, :integer
    add_column :users, :card_type, :string
    add_column :users, :recent_subscription_pymt_date, :datetime
  end
end
