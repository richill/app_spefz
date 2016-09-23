class AddSpeakerDeatilsToSocials < ActiveRecord::Migration
  def change
    add_column :socials, :speakername, :string
    add_column :socials, :speakerlinkedin, :text
  end
end
