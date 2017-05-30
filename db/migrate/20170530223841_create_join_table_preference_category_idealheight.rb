class CreateJoinTablePreferenceCategoryIdealheight < ActiveRecord::Migration
  def change
    create_join_table :preferences, :category_idealheights do |t|
      # t.index [:preference_id, :category_idealheight_id]
      # t.index [:category_idealheight_id, :preference_id]
    end
  end
end
