class AddAlbumidToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :album_id, :integer
  end
end
