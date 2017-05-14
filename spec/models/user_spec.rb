require 'rails_helper'

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    expect(user.username).to eq "Pekka"
  end

  it "is not saved if the username has been taken" do
    user = User.create username:"Pekka", password:"Passwor1", password_confirmation:"Passwor1"
    user2 = User.create username:"Pekka", password:"Passwor1", password_confirmation:"Passwor1"

    expect(user2).not_to be_valid
    expect(User.count).to eq(1)
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with blank password" do
    user = User.create username:"Pekka", password:"  ", password_confirmation:"  "

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with inproper password" do
    user = User.create username:"Pekka", password:"Kaalikääryleitä", password_confirmation:"Kaalikääryleitä"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is saved with a proper password" do
    user = User.create username:"Pekka", password:"Passwor1", password_confirmation:"Passwor1"

    expect(user).to be_valid
    expect(User.count).to eq(1)
  end

  describe "score" do
    it "has a method score" do
      user = User.new
      expect(user).to respond_to(:score)
    end

    it "with 1 goal checked, score returns that goal's points" do
      user = User.create username:"Pekka", password:"Passwor1", password_confirmation:"Passwor1"
      goal = Goal.create name:"goal", score:2
      ug = UserGoal.create goal_id:goal.id, user_id:user.id

      expect(user.score).to eq(2)
    end

    it "with 2 of the same goal checked, score return the sum of the goal points" do
      user = User.create username:"Pekka", password:"Passwor1", password_confirmation:"Passwor1"
      goal = Goal.create name:"goal", score:2
      ug1 = UserGoal.create goal_id:goal.id, user_id:user.id
      ug2 = UserGoal.create goal_id:goal.id, user_id:user.id

      expect(user.score).to eq(4)
    end

    it "with 2 different goals checked, score return the sum of the goal points" do
      user = User.create username:"Pekka", password:"Passwor1", password_confirmation:"Passwor1"
      goal = Goal.create name:"goal", score:2
      goal2 = Goal.create name:"goal2", score:5
      ug1 = UserGoal.create goal_id:goal.id, user_id:user.id
      ug2 = UserGoal.create goal_id:goal2.id, user_id:user.id

      expect(user.score).to eq(7)
    end
  end
end
