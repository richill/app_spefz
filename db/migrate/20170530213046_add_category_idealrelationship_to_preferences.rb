class AddCategoryIdealrelationshipToPreferences < ActiveRecord::Migration
  def change
    add_column :preferences, :category_idealrelationship_id, :integer
  end
end
