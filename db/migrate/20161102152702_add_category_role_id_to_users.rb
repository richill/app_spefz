class AddCategoryRoleIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :category_role_id, :integer
  end
end
