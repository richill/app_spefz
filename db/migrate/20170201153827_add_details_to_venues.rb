class AddDetailsToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :category_country_id, :integer
    add_column :venues, :city, :string
  end
end
