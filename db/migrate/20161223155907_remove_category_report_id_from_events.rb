class RemoveCategoryReportIdFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :category_report_id, :integer
  end
end
