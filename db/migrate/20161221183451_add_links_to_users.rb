class AddLinksToUsers < ActiveRecord::Migration
  def change
    add_column :users, :link_fb, :string
    add_column :users, :link_twitter, :string
  end
end
