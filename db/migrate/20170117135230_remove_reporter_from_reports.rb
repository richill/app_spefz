class RemoveReporterFromReports < ActiveRecord::Migration
  def change
    remove_column :reports, :reporter, :integer
  end
end
