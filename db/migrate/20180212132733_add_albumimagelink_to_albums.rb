class AddAlbumimagelinkToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :album_image_link, :string
  end
end
