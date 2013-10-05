json.array!(@categories) do |category|
  json.extract! category, :title
  json.url category_url(category, format: :json)
end
