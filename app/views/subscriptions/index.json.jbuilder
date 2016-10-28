json.array!(@subscriptions) do |subscription|
  json.extract! subscription, :id, :title, :price
  json.url subscription_url(subscription, format: :json)
end
