class User < ApplicationRecord

  validates :username, uniqueness: true,
                   length: { in: 3..30 }

  validates :password, format: { with: /(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])/}, length: { minimum: 8 }

  has_secure_password

  has_many :user_goals, dependent: :destroy
  has_many :goals, through: :user_goals

  def score
    self.goals.inject(0){|sum,goal| sum + goal.score }
  end

  def recent_goals
    self.user_goals.sort_by{|ug| ug.created_at }.reverse.take(7)
  end

  def top_goal
    # most times checked
  end

end
