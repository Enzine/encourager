module Helpers

  def sign_in(credentials)
    visit login_path
    fill_in('username', with:credentials[:username])
    fill_in('password', with:credentials[:password])
    click_button('Login')
  end
end
