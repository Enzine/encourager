require 'rails_helper'

describe "Goal" do
  before :each do
    @goal = FactoryGirl.create(:goal)
    @user = FactoryGirl.create :user
    visit login_path
    fill_in('username', with:'Pekka')
    fill_in('password', with:'Passwor1')
    click_button('Login')
  end

  it "is created when given valid credentials" do
    visit new_goal_path

    fill_in('goal[name]', with:'Goal')
    fill_in('goal[score]', with:2)
    expect{
      click_button('Create Goal')
    }.to change{Goal.count}.by(1)
  end

  it "is not created if wrong credentials given" do
    visit new_goal_path

    click_button "Create Goal"

    expect(Goal.count).to be(1)
    expect(page).to have_content "Name can't be blank"
  end

  it "is destroyed when deleted" do
    visit goal_path(@goal)

    click_link "Destroy"

    expect(Goal.count).to eq(0)
    expect(page).to have_content "Goal was successfully destroyed."
  end

  it "is updated when given valid credentials" do
    visit edit_goal_path(@goal)

    fill_in('goal[name]', with:'Supergoal')
    fill_in('goal[score]', with:5)
    click_button "Update Goal"

    expect(page).to have_content "Goal was successfully updated."
  end

  it "is not updated if wrong credentials given" do
    visit edit_goal_path(@goal)

    fill_in('goal[name]', with:'')
    click_button "Update Goal"

    expect(page).to have_content "Name can't be blank"
  end

  it "is added to a user's goals through a user goal when checked" do
    visit goals_path

    click_button "Check"

    expect(@user.goals).not_to be(nil)
    expect(@user.goals.first).to eq(@goal)
    expect(page).to have_content "Goal was successfully added to your goals."
  end

  describe "when goals exist" do
    before :each do
      @goals = [@goal, FactoryGirl.create(:goal2)]

      visit goals_path
    end

    it "lists the goals" do
      @goals.each do |goal|
        expect(page).to have_content goal.name
        expect(page).to have_content goal.score
      end
    end

    it "allows user to navigate to page of a Goal" do
      click_link "goal2"

      expect(page).to have_content "goal2"
      expect(page).to have_content "Available points:"
      expect(page).to have_content "Description:"
    end
  end
end
