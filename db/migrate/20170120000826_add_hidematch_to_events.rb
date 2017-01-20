class AddHidematchToEvents < ActiveRecord::Migration
  def change
    add_column :events, :hide_match, :boolean
  end
end
