class User < ApplicationRecord

  validates :username, uniqueness: true,
                   length: { in: 3..30 }

  has_secure_password

  has_many :user_goals, dependent: :destroy
  has_many :goals, through: :user_goals

  def score
    self.goals.inject(0){|sum,goal| sum + goal.score }
  end

end
