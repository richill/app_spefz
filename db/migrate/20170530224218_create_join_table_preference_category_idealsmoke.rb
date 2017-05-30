class CreateJoinTablePreferenceCategoryIdealsmoke < ActiveRecord::Migration
  def change
    create_join_table :preferences, :category_idealsmokes do |t|
      # t.index [:preference_id, :category_idealsmoke_id]
      # t.index [:category_idealsmoke_id, :preference_id]
    end
  end
end
