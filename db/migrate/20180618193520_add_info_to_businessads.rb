class AddInfoToBusinessads < ActiveRecord::Migration
  def change
    add_column :businessads, :companyname, :string
    add_column :businessads, :imagelink, :string
  end
end
