json.array!(@assessments) do |assessment|
  json.extract! assessment, :id, :mark, :grant_id, :applicant_id, :category_id, :criterion_id
  json.url assessment_url(assessment, format: :json)
end
