class AddSlugToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :slug, :string
    add_index :subscriptions, :slug, unique: true
  end
end
