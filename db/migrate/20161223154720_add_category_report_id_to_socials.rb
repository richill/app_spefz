class AddCategoryReportIdToSocials < ActiveRecord::Migration
  def change
    add_column :socials, :category_report_id, :integer
  end
end
