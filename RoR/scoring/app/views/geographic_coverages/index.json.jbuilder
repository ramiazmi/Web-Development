json.array!(@geographic_coverages) do |geographic_coverage|
  json.extract! geographic_coverage, :id, :beneficiaries_number, :proposal_id, :locality_id
  json.url geographic_coverage_url(geographic_coverage, format: :json)
end
