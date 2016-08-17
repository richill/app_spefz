json.array!(@socials) do |social|
  json.extract! social, :id, :title, :description, :address, :postcode, :latitude, :longitude, :user_id
  json.url social_url(social, format: :json)
end
