class AddCategoryMatchstatusIdToPreferences < ActiveRecord::Migration
  def change
    add_column :preferences, :category_matchstatus_id, :integer
  end
end
