# Structure:
# Feature
    # Describe
        # Context
            # Scenario

require 'spec_helper'
require 'rails_helper'

feature "commenting" do

    given!(:demo_user) { FactoryBot.create(:user) }
    given!(:guest_user) { FactoryBot.create(:user) }
    given!(:goal) { FactoryBot.create(:goal, author: demo_user) }
    
    background(:each) {
        login(guest_user)
        visit goal_url(goal)
    }

    shared_examples "cheer" do 
        scenario "should have cheer field" do
            expect(page).to have_selector("input[type=submit][value='Give Cheer']") 
        end 
        scenario "should save the new cheer" do
            click_button "Give Cheer"
            expect(page).to have_content "You cheered #{demo_user.username}'s goal!"
        end
    end

    describe "does not cheer your own goal" do
        scenario "expect cheer field not exist" do 
            click_button "Log Out"
            login(demo_user)
            visit goal_url(goal)
            expect(page).not_to have_field("Give Cheer")
        end
    end

    describe "cheers on other user's goal" do
        it_behaves_like "cheer"
    end

end