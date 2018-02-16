json.array!(@proposals) do |proposal|
  json.extract! proposal, :id, :project_name, :sector_id, :project_background, :proposal_date, :expected_start_date, :project_period, :project_aim, :target_audience, :development_goal_id, :project_actions_description, :stakeholders_choosing_method, :stakeholders_description, :project_approach, :technical_methodology, :logical_framework, :supervision, :project_sustainability, :executive_organization, :joint_ventures, :organization_experience, :contact_person, :contact_phone, :contact_email, :positive_impact, :negative_impact, :short_term_work_opportunities, :long_term_work_opportunities, :project_schedule, :photos_before_implementation, :project_schedule, :project_photos, :design_readiness_id, :user_id
  json.url proposal_url(proposal, format: :json)
end