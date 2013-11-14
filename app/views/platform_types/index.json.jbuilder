json.array!(@platform_types) do |platform_type|
  json.extract! platform_type, :title
  json.url platform_type_url(platform_type, format: :json)
end
