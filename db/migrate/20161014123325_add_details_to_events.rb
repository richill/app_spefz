class AddDetailsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :category_topic_id, :integer
    add_column :events, :image, :string
    add_column :events, :date, :date
    add_column :events, :time, :time
    add_column :events, :city, :string
    add_column :events, :quantity, :integer
    add_column :events, :category_age_id, :integer
    add_column :events, :category_country_id, :integer
    add_column :events, :quantity_men, :integer
    add_column :events, :quantity_women, :integer
    add_column :events, :category_quantitygender_id, :integer
    add_column :events, :venuename, :string
    add_column :events, :price, :decimal
  end
end
