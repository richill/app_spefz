json.array!(@events) do |event|
  json.extract! event, :id, :title, :description, :address, :postcode, :latitude, :longitude
  json.url event_url(event, format: :json)
end
