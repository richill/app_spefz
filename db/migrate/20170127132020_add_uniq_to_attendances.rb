class AddUniqToAttendances < ActiveRecord::Migration
  def change
    add_index :attendances, :attendable_id, unique: true
    add_index :attendances, :attendable_type, unique: true
  end
end
