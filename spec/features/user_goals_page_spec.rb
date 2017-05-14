require 'rails_helper'

describe "UserGoal" do
  before :each do
    @goal = FactoryGirl.create(:goal)
    @user = FactoryGirl.create(:user)
    @ug = UserGoal.create goal_id:@goal.id, user_id:@user.id
    visit login_path
    fill_in('username', with:'Pekka')
    fill_in('password', with:'Passwor1')
    click_button('Login')
  end

  it "is updated when given valid credentials" do
    visit edit_user_goal_path(@ug)

    fill_in('user_goal[stars]', with:'5')

    click_button "Update goal"

    expect(page).to have_content "Your goal was successfully updated."
    expect(page).to have_content "2 points was received."
  end

  it "is destroyed when deleted" do
    visit user_goal_path(@ug)

    click_link "Destroy"

    expect(UserGoal.count).to eq(0)
    expect(page).to have_content "Your goal was successfully destroyed."
  end
end
