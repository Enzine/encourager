require 'rails_helper'

RSpec.describe Goal, type: :model do
  it "is not saved without a name" do
    goal = Goal.create score:1

    expect(goal).not_to be_valid
    expect(Goal.count).to eq(0)
  end

  it "is not saved with a blank name" do
    goal = Goal.create name:"  ", score:1

    expect(goal).not_to be_valid
    expect(Goal.count).to eq(0)
  end

  it "is not saved without a score" do
    goal = Goal.create name:"goal"

    expect(goal).not_to be_valid
    expect(Goal.count).to eq(0)
  end

  it "is not saved with a negative score" do
    goal = Goal.create name:"goal", score:-1

    expect(goal).not_to be_valid
    expect(Goal.count).to eq(0)
  end

  it "is not saved with a good name and score less than 1" do
    goal = Goal.create name:"goal", score:0

    expect(goal).not_to be_valid
    expect(Goal.count).to eq(0)
  end

  it "is not saved with a good name and score over 10" do
    goal = Goal.create name:"goal", score:11

    expect(goal).not_to be_valid
    expect(Goal.count).to eq(0)
  end

  it "is saved with a good name and score of 1" do
    goal = Goal.create name:"goal", score:1

    expect(goal).to be_valid
    expect(Goal.count).to eq(1)
  end

  it "is saved with a good name and a score of 10" do
    goal = Goal.create name:"goal", score:10

    expect(goal).to be_valid
    expect(Goal.count).to eq(1)
  end

  describe "tag_list" do
    before :each do
      @goal = FactoryGirl.create(:goal)
      @tag = FactoryGirl.create(:tag)
      @tag2 = FactoryGirl.create(:tag2)
      Tagging.create tag_id:@tag.id, goal_id:@goal.id
    end

    it "has a method tag_list" do
      expect(@goal).to respond_to(:tag_list)
    end

    it "with 1 tag, tag_list returns that tag's name" do
      expect(@goal.tag_list).to eq "tag"
    end

    it "with 2 tags, tag_list returns tags' names divided by comma" do
      Tagging.create tag_id:@tag2.id, goal_id:@goal.id
      expect(@goal.tag_list).to eq "tag, tag2"
    end

    it "tags can be added with tag_list" do
      @goal = Goal.create name:"goal", score:2
      @goal.tag_list = "tag, tag2, tag3"

      expect(@goal.tag_list).to eq "tag, tag2, tag3"
    end
  end
end
