require 'spec_helper'
require 'rails_helper'


feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content "Sign Up"
  end

  feature 'signing up a user' do
    scenario 'shows username on the homepage after signup' do
        visit new_user_url
        fill_in "username", with: "harrylau"
        fill_in "password", with: "password123"
        click_button "Sign Up"
        expect(page).to have_content "harrylau"
    end
  end
end

feature 'logging in' do
  scenario 'shows username on the homepage after login' do 
    user = FactoryBot.create(:user)
    login(user)
    expect(page).to have_content(user.username)
  end

  scenario 'shows error message on invalid login' do 
    user = FactoryBot.create(:user, username: "baduser", password: 'badpassword')
    bad_login(user)
    expect(page).to have_content "Invalid Credentials"
  end
end

feature 'logging out' do
  scenario 'begins with a logged out state' do
    visit root_url
    expect(page).to have_content "Log In"
  end

  scenario 'doesn\'t show username on the homepage after logout' do
    user = FactoryBot.create(:user)
    login(user)
    click_button "Log Out"
    expect(page).not_to have_content(user.username)
  end

end

# Notes: 
# New Dir support
# Create File auth_helper.rb

# To include it, in rails_helper.rb, uncomment
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Then add, 
# config.include AuthHelper, type: :feature
# In this file, module AuthHelper, add #login, #sign_up methods