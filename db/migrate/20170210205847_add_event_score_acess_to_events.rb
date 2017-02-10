class AddEventScoreAcessToEvents < ActiveRecord::Migration
  def change
    add_column :events, :event_score_access, :integer
  end
end
