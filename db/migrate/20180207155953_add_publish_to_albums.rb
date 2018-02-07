class AddPublishToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :publish, :boolean
  end
end
