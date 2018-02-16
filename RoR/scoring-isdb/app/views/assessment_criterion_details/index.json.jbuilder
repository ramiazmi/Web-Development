json.array!(@assessment_criterion_details) do |assessment_criterion_detail|
  json.extract! assessment_criterion_detail, :id, :mark, :criterion_detail_id, :assessment_id
  json.url assessment_criterion_detail_url(assessment_criterion_detail, format: :json)
end
