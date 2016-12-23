class RemoveCategoryReportIdFromSocials < ActiveRecord::Migration
  def change
    remove_column :socials, :category_report_id, :integer
  end
end
