class AddNotesToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :note, :text
  end
end
