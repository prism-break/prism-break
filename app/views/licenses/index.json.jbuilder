json.array!(@licenses) do |license|
  json.extract! license, :title, :description, :url
  json.url license_url(license, format: :json)
end
