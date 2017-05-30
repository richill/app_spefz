class AddCategoryMatchidsToPreferences < ActiveRecord::Migration
  def change
    add_column :preferences, :category_matchkid_id, :integer
    add_column :preferences, :category_matcheducation_id, :integer
    add_column :preferences, :category_matchheight_id, :integer
    add_column :preferences, :category_matchbodytype_id, :integer
    add_column :preferences, :category_matchethnicity_id, :integer
    add_column :preferences, :category_matchreligion_id, :integer
    add_column :preferences, :category_matchsmoke_id, :integer
  end
end
