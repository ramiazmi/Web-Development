json.array!(@funds) do |fund|
  json.extract! fund, :id, :percentage, :fund_source_id, :proposal
  json.url fund_url(fund, format: :json)
end
