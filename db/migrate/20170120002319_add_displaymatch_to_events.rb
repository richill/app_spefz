class AddDisplaymatchToEvents < ActiveRecord::Migration
  def change
    add_column :events, :display_match, :boolean
  end
end
