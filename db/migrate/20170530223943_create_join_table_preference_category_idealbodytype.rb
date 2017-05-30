class CreateJoinTablePreferenceCategoryIdealbodytype < ActiveRecord::Migration
  def change
    create_join_table :preferences, :category_idealbodytypes do |t|
      # t.index [:preference_id, :category_idealbodytype_id]
      # t.index [:category_idealbodytype_id, :preference_id]
    end
  end
end
