class AddImagedetailsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :imgvenue_one, :string
    add_column :events, :imgvenue_two, :string
    add_column :events, :imgvenue_three, :string
    add_column :events, :imgevent_one, :string
    add_column :events, :imgevent_two, :string
    add_column :events, :imgevent_three, :string
    add_column :events, :imgevent_four, :string
    add_column :events, :imgevent_five, :string
    add_column :events, :imgevent_six, :string
  end
end
