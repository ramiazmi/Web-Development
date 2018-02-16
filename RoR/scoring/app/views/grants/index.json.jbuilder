json.array!(@grants) do |grant|
  json.extract! grant, :id, :description, :is_active
  json.url grant_url(grant, format: :json)
end
