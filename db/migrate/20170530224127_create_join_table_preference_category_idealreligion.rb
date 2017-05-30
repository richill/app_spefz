class CreateJoinTablePreferenceCategoryIdealreligion < ActiveRecord::Migration
  def change
    create_join_table :preferences, :category_idealreligions do |t|
      # t.index [:preference_id, :category_idealreligion_id]
      # t.index [:category_idealreligion_id, :preference_id]
    end
  end
end
