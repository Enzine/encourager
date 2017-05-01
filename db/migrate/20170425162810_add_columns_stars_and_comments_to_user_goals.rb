class AddColumnsStarsAndCommentsToUserGoals < ActiveRecord::Migration[5.0]
  def change
    add_column :user_goals, :stars, :integer
    add_column :user_goals, :comments, :string
  end
end
