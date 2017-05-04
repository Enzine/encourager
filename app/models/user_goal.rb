class UserGoal < ApplicationRecord
  belongs_to :user
  belongs_to :goal

  validates :stars, numericality: {greater_than: 0, less_than: 6, allow_blank: false}
end
