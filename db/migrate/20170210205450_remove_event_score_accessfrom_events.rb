class RemoveEventScoreAccessfromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :event_score_access, :string
  end
end
