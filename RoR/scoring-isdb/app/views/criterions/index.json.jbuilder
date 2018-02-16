json.array!(@criterions) do |criterion|
  json.extract! criterion, :id, :description, :is_active, :category_id
  json.url criterion_url(criterion, format: :json)
end
