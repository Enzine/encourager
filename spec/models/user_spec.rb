require 'rails_helper'

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    expect(user.username).to eq "Pekka"
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


end
