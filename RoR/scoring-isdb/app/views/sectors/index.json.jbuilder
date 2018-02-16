json.array!(@sectors) do |sector|
  json.extract! sector, :id, :programme, :percentage, :is_active
  json.url sector_url(sector, format: :json)
end
