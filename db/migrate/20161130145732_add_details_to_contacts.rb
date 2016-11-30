class AddDetailsToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :lastname, :string
    add_column :contacts, :companyname, :string
  end
end
