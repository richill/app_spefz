class AddDetailsToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :user_firstname, :string
    add_column :payments, :user_lastname, :string
    add_column :payments, :user_gender, :string
    add_column :payments, :user_gender_id, :integer
    add_column :payments, :spefz_user_ref, :string
    add_column :payments, :spefz_payment_ref, :string
    add_column :payments, :spefz_event_ref, :string
    add_column :payments, :spefz_subscription_ref, :string
    add_column :payments, :product, :string
    add_column :payments, :product_price, :decimal
    add_column :payments, :stripe_customer_id, :string
    add_column :payments, :stripe_subscription_id, :string
    add_column :payments, :stripe_payment_id, :string
    add_column :payments, :subscription_payment_date, :datetime
    add_column :payments, :event_payment_date, :datetime
    add_column :payments, :user_card_type, :string
    add_column :payments, :user_card_last4, :string
    add_column :payments, :user_card_exp_month, :integer
    add_column :payments, :user_card_exp_year, :integer
    add_column :payments, :staus, :string
  end
end
