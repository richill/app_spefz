class AddSocialIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :social_id, :integer
  end
end
