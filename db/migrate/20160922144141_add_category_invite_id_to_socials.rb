class AddCategoryInviteIdToSocials < ActiveRecord::Migration
  def change
    add_column :socials, :category_invite_id, :integer
  end
end
