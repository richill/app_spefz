class AddCategoryMatchparentToPreferences < ActiveRecord::Migration
  def change
    add_column :preferences, :category_matchparent_id, :integer
  end
end
