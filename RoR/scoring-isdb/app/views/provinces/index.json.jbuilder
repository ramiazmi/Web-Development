json.array!(@provinces) do |province|
  json.extract! province, :id, :name, :percentage
  json.url province_url(province, format: :json)
end
