class AddDetailsToBusinessads < ActiveRecord::Migration
  def change
    add_column :businessads, :reference, :string
    add_column :businessads, :publishdate_start, :date
    add_column :businessads, :publishdate_end, :date
    add_column :businessads, :price, :decimal
    add_column :businessads, :clientname, :string
    add_column :businessads, :clientjob, :string
    add_column :businessads, :clientcontact, :string
  end
end
