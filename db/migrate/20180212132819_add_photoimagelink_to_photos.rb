class AddPhotoimagelinkToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :photo_image_link, :string
  end
end
