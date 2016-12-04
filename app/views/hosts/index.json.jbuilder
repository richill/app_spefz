json.array!(@hosts) do |host|
  json.extract! host, :id, :event_id
  json.url host_url(host, format: :json)
end
