class AddEventscoreaccessToEvents < ActiveRecord::Migration
  def change
    add_column :events, :event_score_access, :string
  end
end
