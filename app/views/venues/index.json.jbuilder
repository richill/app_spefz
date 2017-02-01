json.array!(@venues) do |venue|
  json.extract! venue, :id, :venuename, :address, :postcode, :maplink, :station, :price, :min_capacity, :eventmanager, :contact, :image
  json.url venue_url(venue, format: :json)
end
