class AddReferenceToReports < ActiveRecord::Migration
  def change
    add_column :reports, :reference, :string
  end
end
