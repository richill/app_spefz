class RemoveHostIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :host_id, :integer
  end
end
