class AddCategoryReportIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :category_report_id, :integer
  end
end
