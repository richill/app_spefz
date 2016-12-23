class RemoveCategoryReportIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :category_report_id, :integer
  end
end
