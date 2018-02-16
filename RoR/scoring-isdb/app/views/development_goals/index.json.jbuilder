json.array!(@development_goals) do |development_goal|
  json.extract! development_goal, :id, :description, :is_active
  json.url development_goal_url(development_goal, format: :json)
end
