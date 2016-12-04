class AddHostDescriptionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :host_description, :text
  end
end
