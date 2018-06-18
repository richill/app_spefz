class AddUseridtoBusinessads < ActiveRecord::Migration
  def change
    add_column :businessads, :user_id, :integer
  end
end
