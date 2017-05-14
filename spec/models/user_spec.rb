require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = FactoryGirl.create(:user)
  end

  it "has the username set correctly" do
    expect(@user.username).to eq "Pekka"
  end

  it "is not saved if the username has been taken" do
    user2 = User.create username:"Pekka", password:"Passwor1", password_confirmation:"Passwor1"

    expect(user2).not_to be_valid
    expect(User.count).to eq(1)
  end

  it "is not saved without a password" do
    user2 = User.create username:"Pekka"

    expect(user2).not_to be_valid
    expect(User.count).to eq(1)
  end

  it "is not saved with blank password" do
    user2 = User.create username:"Matti", password:"  ", password_confirmation:"  "

    expect(user2).not_to be_valid
    expect(User.count).to eq(1)
  end

  it "is not saved with an inproper password" do
    user2 = User.create username:"Matti", password:"Kaalikääryleitä", password_confirmation:"Kaalikääryleitä"

    expect(user2).not_to be_valid
    expect(User.count).to eq(1)
  end

  it "is saved with a proper password" do
    expect(User.count).to eq(1)
  end

  describe "score" do
    before :each do
      @goal = FactoryGirl.create(:goal)
    end

    it "has a method score" do
      expect(@user).to respond_to(:score)
    end

    it "with 1 goal checked, score returns that goal's points" do
      UserGoal.create goal_id:@goal.id, user_id:@user.id

      expect(@user.score).to eq(2)
    end

    it "with 2 of the same goal checked, score return the sum of the goal points" do
      goal2 = FactoryGirl.create(:goal)
      UserGoal.create goal_id:@goal.id, user_id:@user.id
      UserGoal.create goal_id:goal2.id, user_id:@user.id

      expect(@user.score).to eq(4)
    end

    it "with 2 different goals checked, score return the sum of the goal points" do
      goal2 = FactoryGirl.create(:goal2)
      ug1 = UserGoal.create goal_id:@goal.id, user_id:@user.id
      ug2 = UserGoal.create goal_id:goal2.id, user_id:@user.id

      expect(@user.score).to eq(7)
    end
  end
end
