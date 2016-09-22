class AddDateTimeToSocials < ActiveRecord::Migration
  def change
    add_column :socials, :date, :date
    add_column :socials, :time, :time
  end
end
