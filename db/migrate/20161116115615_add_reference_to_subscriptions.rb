class AddReferenceToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :reference, :string
  end
end
