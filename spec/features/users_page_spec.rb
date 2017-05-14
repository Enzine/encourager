require 'rails_helper'

describe "User" do
  before :each do
    @user = FactoryGirl.create(:user)
    visit login_path
    fill_in('username', with:'Pekka')
    fill_in('password', with:'Passwor1')
    click_button('Login')
  end

  it "is created when given valid credentials" do
    visit new_user_path

    fill_in('user[username]', with:'Paavo')
    fill_in('user[password]', with:'Passwor1')
    fill_in('user[password_confirmation]', with:'Passwor1')
    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  it "is not created if wrong credentials given" do
    visit new_user_path

    fill_in('user[username]', with:'Paavo')
    fill_in('user[password]', with:'Passwor1')
    fill_in('user[password_confirmation]', with:'Pst')

    click_button "Create User"

    expect(User.count).to eq(1)
    expect(page).to have_content "Password confirmation doesn't match Password"
  end

  it "is destroyed when deleted" do
    visit user_path(@user)

    click_link "Destroy account"

    expect(User.count).to eq(0)
    expect(page).to have_content "User was successfully destroyed."
  end

  it "is updated when given valid credentials" do
    visit edit_user_path(@user)

    fill_in('user[password]', with:'Passwor2')
    fill_in('user[password_confirmation]', with:'Passwor2')

    click_button "Update User"

    expect(page).to have_content "User was successfully updated."
  end

  it "is not updated if wrong credentials given" do
    visit edit_user_path(@user)

    fill_in('user[password]', with:'')
    click_button "Update User"

    expect(page).to have_content "Password is invalid"
  end
end
