json.array!(@invites) do |invite|
  json.extract! invite, :id, :user_id, :invitee_id, :social_id, :event_id
  json.url invite_url(invite, format: :json)
end
