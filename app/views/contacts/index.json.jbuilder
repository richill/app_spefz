json.array!(@contacts) do |contact|
  json.extract! contact, :id, :name, :email, :message, :category_enquiry_id, :tel, :status, :reference, :category_contactclient_id
  json.url contact_url(contact, format: :json)
end
