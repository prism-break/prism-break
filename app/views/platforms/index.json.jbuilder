json.array!(@platforms) do |platform|
  json.extract! platform, :title, :description, :wikipedia_url
  json.url platform_url(platform, format: :json)
end
