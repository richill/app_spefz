class AddUniqToAttendances < ActiveRecord::Migration
  def change
    add_index :attendances, [:attendable_id, :attendable_type], unique: true
  end
end
