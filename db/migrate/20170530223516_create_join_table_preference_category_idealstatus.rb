class CreateJoinTablePreferenceCategoryIdealstatus < ActiveRecord::Migration
  def change
    create_join_table :preferences, :category_idealstatuses do |t|
      # t.index [:preference_id, :category_idealstatus_id]
      # t.index [:category_idealstatus_id, :preference_id]
    end
  end
end
