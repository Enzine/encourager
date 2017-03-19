json.extract! user_goal, :id, :user_id, :goal_id, :created_at, :updated_at
json.url user_goal_url(user_goal, format: :json)
