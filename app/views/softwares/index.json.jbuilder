json.array!(@softwares) do |software|
  json.extract! software, :title, :description, :url, :source_url, :privacy_url, :tos_url
  json.url software_url(software, format: :json)
end
