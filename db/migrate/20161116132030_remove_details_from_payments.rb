class RemoveDetailsFromPayments < ActiveRecord::Migration
  def change
    remove_column :payments, :user_firstname, :string
    remove_column :payments, :user_lastname, :string
    remove_column :payments, :user_gender, :string
    remove_column :payments, :user_gender_id, :integer
    remove_column :payments, :spefz_user_ref, :string
    remove_column :payments, :spefz_payment_ref, :string
    remove_column :payments, :spefz_event_ref, :string
    remove_column :payments, :spefz_subscription_ref, :string
    remove_column :payments, :product, :string
    remove_column :payments, :product_price, :decimal
  end
end
