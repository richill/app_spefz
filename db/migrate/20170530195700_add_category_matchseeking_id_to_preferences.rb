class AddCategoryMatchseekingIdToPreferences < ActiveRecord::Migration
  def change
    add_column :preferences, :category_matchseeking_id, :integer
  end
end
