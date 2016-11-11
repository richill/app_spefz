class AddCloseToEvents < ActiveRecord::Migration
  def change
    add_column :events, :close, :boolean
  end
end
