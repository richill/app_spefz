class AddEventimgurlToEvents < ActiveRecord::Migration
  def change
    add_column :events, :event_image_link, :string
  end
end
