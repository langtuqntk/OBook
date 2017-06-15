json.array!(@categories) do |category|
  json.extract! category, :id, :categoryname, :description, :level
  json.url category_url(category, format: :json)
end
