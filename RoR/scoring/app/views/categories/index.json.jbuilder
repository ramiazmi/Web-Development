json.array!(@categories) do |category|
  json.extract! category, :id, :description, :is_active
  json.url category_url(category, format: :json)
end
