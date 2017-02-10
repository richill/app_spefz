class UpdateEventscoreaccessUnderEvents < ActiveRecord::Migration
  def change
    change_column :events, :event_score_access, :integer
  end
end
