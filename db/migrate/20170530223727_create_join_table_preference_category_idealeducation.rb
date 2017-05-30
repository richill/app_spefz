class CreateJoinTablePreferenceCategoryIdealeducation < ActiveRecord::Migration
  def change
    create_join_table :preferences, :category_idealeducations do |t|
      # t.index [:preference_id, :category_idealeducation_id]
      # t.index [:category_idealeducation_id, :preference_id]
    end
  end
end
