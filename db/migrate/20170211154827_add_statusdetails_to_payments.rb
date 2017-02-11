class AddStatusdetailsToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :event_payment_date_status, :string
    add_column :payments, :subscription_payment_date_status, :string
  end
end
