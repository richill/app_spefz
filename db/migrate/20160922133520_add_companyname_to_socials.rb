class AddCompanynameToSocials < ActiveRecord::Migration
  def change
    add_column :socials, :companyname, :string
  end
end
