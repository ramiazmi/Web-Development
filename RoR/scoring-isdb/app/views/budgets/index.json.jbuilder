json.array!(@budgets) do |budget|
  json.extract! budget, :id, :project_action, :cost_type, :cost, :proposal_id
  json.url budget_url(budget, format: :json)
end
