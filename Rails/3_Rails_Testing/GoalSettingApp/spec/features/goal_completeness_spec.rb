# Structure:
# Feature
    # Describe
        # Context
            # Scenario

require 'spec_helper'
require 'rails_helper'

feature "the completeness of goals" do

    given!(:demo_user) { FactoryBot.create(:user) }
    given!(:guest_user) { FactoryBot.create(:user) }
    given!(:goal) { FactoryBot.create(:goal, author: demo_user) }
    background(:each) {
        login(demo_user)
    }

    describe "goal should start out incomplete" do
        context "on the goal show page" do
            scenario "starts out as incomplete" do
                visit goal_url(goal)
                expect(page).to have_content("Ongoing")
            end
        end
        context "on the goal index page" do 
            scenario "starts out as incomplete" do
                visit goals_url
                expect(page).to have_content("Ongoing")
            end
        end
        context "on the user's profile page" do 
            scenario "starts out as incomplete" do
                visit user_url(demo_user)
                expect(page).to have_content(goal.title)
                expect(page).to have_content("Ongoing")
            end
        end
    end

    describe "mark goal as complete" do 
        context "on the goal show page" do 
            scenario "allows user to complete own goal" do 
                visit goal_url(goal)
                click_button "goal_#{goal.id}_complete"
                expect(page).to have_content("Goal Complete!")
            end
            scenario "redirects to same page after completing goal" do 
                visit goal_url(goal)
                click_button "goal_#{goal.id}_complete"
                expect(page).to have_content("Title:")
                expect(page).to have_content(goal.title)
            end
            scenario "disallow other user to complete user's goal" do 
                click_button "Log Out"
                login(guest_user)
                visit goal_url(goal)
                expect(page).not_to have_button("Complete")
            end
        end

        context "on the index page" do
            scenario "allows user to complete own goal" do 
                visit goals_url
                click_button "goal_#{goal.id}_complete"
                expect(page).to have_content("Goal Complete!")
            end
            scenario "redirects to same page after completing goal" do 
                visit goals_url
                click_button "goal_#{goal.id}_complete"
                expect(page).to have_content("Your Goals")
            end
        end

        context "on the user's profile page" do 
            scenario "allows user to complete own goal" do 
                visit user_url(demo_user)
                click_button "goal_#{goal.id}_complete"
                expect(page).to have_content("Goal Complete!")
            end
            scenario "redirects to same page after completing goal" do 
                visit user_url(demo_user)
                click_button "goal_#{goal.id}_complete"
                expect(page).to have_content("#{demo_user.username}'s Goals")
            end
            scenario "disallow other user to complete user's goal" do
                click_button "Log Out"
                login(guest_user)
                visit user_url(demo_user)
                expect(page).not_to have_button "goal_#{goal.id}_complete"
            end
        end
    end
end