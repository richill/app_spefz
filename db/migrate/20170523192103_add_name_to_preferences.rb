class AddNameToPreferences < ActiveRecord::Migration
  def change
    add_column :preferences, :name, :string
  end
end
