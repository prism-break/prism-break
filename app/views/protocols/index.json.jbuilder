json.array!(@protocols) do |protocol|
  json.extract! protocol, :title, :description, :url
  json.url protocol_url(protocol, format: :json)
end
