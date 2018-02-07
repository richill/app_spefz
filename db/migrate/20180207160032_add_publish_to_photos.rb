class AddPublishToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :publish, :boolean
  end
end
