require 'rails_helper'

RSpec.describe UserGoal, type: :model do
  before :each do
    @user = FactoryGirl.create(:user)
    @goal = FactoryGirl.create(:goal)
  end
  it "is not valid if stars column is less than 1" do
    ug = UserGoal.create goal_id:@goal.id, user_id:@user.id, stars:0

    expect(ug).not_to be_valid
    expect(UserGoal.count).to eq(0)
  end

  it "is not valid if stars column is more than 5" do
    ug = UserGoal.create goal_id:@goal.id, user_id:@user.id, stars:6

    expect(ug).not_to be_valid
    expect(UserGoal.count).to eq(0)
  end
end
