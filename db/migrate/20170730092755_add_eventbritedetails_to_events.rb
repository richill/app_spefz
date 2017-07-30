class AddEventbritedetailsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :external_event, :boolean
    add_column :events, :external_eventlink, :text
    add_column :events, :soldout, :boolean
  end
end
