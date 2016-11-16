class AddReferenceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reference, :string
  end
end
