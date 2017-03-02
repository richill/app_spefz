class AddCompanyimageToSocials < ActiveRecord::Migration
  def change
    add_column :socials, :company_image, :boolean
  end
end
