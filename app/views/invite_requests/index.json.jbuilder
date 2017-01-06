json.array!(@invite_requests) do |invite_request|
  json.extract! invite_request, :id, :user_id, :inviter_id, :social_id, :event_id, :status
  json.url invite_request_url(invite_request, format: :json)
end
