class AddReporterIdToReports < ActiveRecord::Migration
  def change
    add_column :reports, :reporter, :integer
  end
end
