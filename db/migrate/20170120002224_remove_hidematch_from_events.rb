class RemoveHidematchFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :hide_match, :boolean
  end
end
