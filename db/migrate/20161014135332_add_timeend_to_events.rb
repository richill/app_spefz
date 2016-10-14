class AddTimeendToEvents < ActiveRecord::Migration
  def change
    add_column :events, :time_end, :time
  end
end
