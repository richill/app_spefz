class AddSoldoutdetailsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :soldout_men, :boolean
    add_column :events, :soldout_women, :boolean
  end
end
