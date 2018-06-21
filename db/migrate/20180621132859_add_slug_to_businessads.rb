class AddSlugToBusinessads < ActiveRecord::Migration
  def change
    add_column :businessads, :slug, :string
    add_index :businessads, :slug, unique: true
  end
end
