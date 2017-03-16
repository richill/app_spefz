json.array!(@managements) do |management|
  json.extract! management, :id, :venuecost, :hostcost
  json.url management_url(management, format: :json)
end
