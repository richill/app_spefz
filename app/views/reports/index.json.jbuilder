json.array!(@reports) do |report|
  json.extract! report, :id, :content, :category_report_id, :event_id, :social_id, :user_id
  json.url report_url(report, format: :json)
end
