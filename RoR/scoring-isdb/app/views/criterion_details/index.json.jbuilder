json.array!(@criterion_details) do |criterion_detail|
  json.extract! criterion_detail, :id, :description, :weight, :is_active, :criterion_id
  json.url criterion_detail_url(criterion_detail, format: :json)
end
