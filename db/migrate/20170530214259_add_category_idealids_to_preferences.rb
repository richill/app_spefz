class AddCategoryIdealidsToPreferences < ActiveRecord::Migration
  def change
    add_column :preferences, :category_idealstatus_id, :integer
    add_column :preferences, :category_idealparent_id, :integer
    add_column :preferences, :category_idealkid_id, :integer
    add_column :preferences, :category_idealeducation_id, :integer
    add_column :preferences, :category_idealheight_id, :integer
    add_column :preferences, :category_idealbodytype_id, :integer
    add_column :preferences, :category_idealethnicity_id, :integer
    add_column :preferences, :category_idealreligion_id, :integer
    add_column :preferences, :category_idealsmoke_id, :integer
  end
end
