class Goal < ApplicationRecord

  validates :name, presence: true, allow_blank: false
  validates :score, numericality: {greater_than: 0, less_than: 11}, length: { in: 1..10 }

  has_many :user_goals, dependent: :destroy
  has_many :users, through: :user_goals
end
