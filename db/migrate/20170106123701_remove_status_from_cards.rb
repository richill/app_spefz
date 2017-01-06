class RemoveStatusFromCards < ActiveRecord::Migration
  def change
    remove_column :cards, :status, :string
  end
end
