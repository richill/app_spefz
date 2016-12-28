json.array!(@cards) do |card|
  json.extract! card, :id, :title, :event_id
  json.url card_url(card, format: :json)
end
