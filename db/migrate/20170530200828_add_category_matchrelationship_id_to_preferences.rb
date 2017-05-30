class AddCategoryMatchrelationshipIdToPreferences < ActiveRecord::Migration
  def change
    add_column :preferences, :category_matchrelationship_id, :integer
  end
end
