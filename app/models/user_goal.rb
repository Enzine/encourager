class UserGoal < ApplicationRecord
  belongs_to :users
  belongs_to :goals
end
