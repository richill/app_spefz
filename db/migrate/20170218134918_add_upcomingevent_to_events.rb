class AddUpcomingeventToEvents < ActiveRecord::Migration
  def change
    add_column :events, :upcoming_event, :boolean
  end
end
