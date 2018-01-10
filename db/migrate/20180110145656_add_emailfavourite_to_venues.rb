class AddEmailfavouriteToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :email, :string
    add_column :venues, :favourite, :boolean
  end
end
