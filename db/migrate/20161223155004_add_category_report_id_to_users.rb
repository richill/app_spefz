class AddCategoryReportIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :category_report_id, :integer
  end
end
