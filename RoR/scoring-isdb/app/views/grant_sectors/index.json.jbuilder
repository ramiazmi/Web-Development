json.array!(@grant_sectors) do |grant_sector|
  json.extract! grant_sector, :id, :percentage, :grant_id, :sector_id
  json.url grant_sector_url(grant_sector, format: :json)
end
