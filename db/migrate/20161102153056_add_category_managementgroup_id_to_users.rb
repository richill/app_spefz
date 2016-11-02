class AddCategoryManagementgroupIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :category_managementgroup_id, :integer
  end
end
