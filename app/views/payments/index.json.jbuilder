json.array!(@payments) do |payment|
  json.extract! payment, :id, :email, :user_id, :subscription_id, :reference
  json.url payment_url(payment, format: :json)
end
