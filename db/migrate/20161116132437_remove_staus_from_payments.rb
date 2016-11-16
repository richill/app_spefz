class RemoveStausFromPayments < ActiveRecord::Migration
  def change
    remove_column :payments, :staus, :string
  end
end
