class CreateJoinTablePreferenceCategoryIdealethnicity < ActiveRecord::Migration
  def change
    create_join_table :preferences, :category_idealethnicities do |t|
      # t.index [:preference_id, :category_idealethnicity_id]
      # t.index [:category_idealethnicity_id, :preference_id]
    end
  end
end
