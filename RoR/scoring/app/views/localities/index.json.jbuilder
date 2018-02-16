json.array!(@localities) do |locality|
  json.extract! locality, :id, :locality_code, :locality_name, :population, :province_id
  json.url locality_url(locality, format: :json)
end
