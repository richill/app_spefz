class AddCategoryInviteoptionIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :category_inviteoption_id, :integer
  end
end
