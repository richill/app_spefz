class AddIdealageToPreferences < ActiveRecord::Migration
  def change
    add_column :preferences, :idealage_start, :string
    add_column :preferences, :idealage_end, :string
  end
end
