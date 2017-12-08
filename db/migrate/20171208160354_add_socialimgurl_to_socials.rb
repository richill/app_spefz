class AddSocialimgurlToSocials < ActiveRecord::Migration
  def change
    add_column :socials, :social_image_link, :string
  end
end
