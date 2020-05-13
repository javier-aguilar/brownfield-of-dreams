require 'rails_helper'

describe 'As a visitor' do

  visit '/'

  click_on 'Sign In'

  expect(current_path).to eq(login_path)

  click_on 'Sign up now.'

  expect(current_path).to eq(new_user_path)

  tester = {
    email: 'jimbob@aol.com',
    first_name: 'Jim',
    last_name: 'Bob',
    password: 'password',
    password_confirmation: 'password'
  }

  fill_in 'user[email]', with: tester[email]
  fill_in 'user[first_name]', with: tester[first_name]
  fill_in 'user[last_name]', with: tester[last_name]
  fill_in 'user[password]', with: tester[password]
  fill_in 'user[password_confirmation]', with: tester[password]

  click_on'Create Account'

  expect(@user.status).to eql('inactive')
  expect(current_path).to eq(dashboard_path)

  expect(page).to have_content("Logged in as #{@user.first_name}")
  expect(page).to have_content("This account has not yet been activated. Please check your email.")

# Add Magic Email stuff

  expect(@user.status).to eql('active')
  expect(page).to have_content("Thank you! Your account is now activated.")
end
