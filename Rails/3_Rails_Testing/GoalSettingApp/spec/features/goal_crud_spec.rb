require 'spec_helper'
require 'rails_helper'


feature 'the CRUD of goals' do

    given!(:demo_user) { FactoryBot.create(:user, username: 'goal_crud_spec') }

    background(:each) do 
        login(demo_user)
    end

    feature 'create a goal' do
        scenario 'shows a page to create goal' do
            visit new_goal_url
            expect(page).to have_content "New Goal"
        end

        scenario 'shows the goal after creating one' do
            submit_new_goal("Meditate")
            expect(page).to have_content "Meditate"
        end
    end

    feature "read goals" do
        scenario "shows all user's goals in index page" do
            goals = Array.new
            3.times do 
                goals << FactoryBot.build(:goal)
                submit_goal_instance(goals.last) 
            end
            visit goals_url
            goals.map(&:title).all? do |g|
                expect(page).to have_content(g)
            end
        end
    end

    feature "update goals" do
        given!(:old_goal) { FactoryBot.create(:goal, author: demo_user) }
        
        scenario "shows a page to update an existing goal" do
            visit edit_goal_url(old_goal)
            expect(page).to have_content "Edit Goal"
        end
        
        scenario "shows goal updated" do 
            visit edit_goal_url(old_goal)
            fill_in "goal_title", with: "Updated Goal"
            click_button "Update Goal"
            expect(page).not_to have_content "Edit Goal"
            expect(page).to have_content "Goal Updated!"
            expect(page).to have_content "Updated Goal"
        end    
    end

    feature "delete goals" do
        given!(:old_goal) { FactoryBot.create(:goal, author: demo_user) }
        scenario "deletes from index page" do 
            visit goals_url
            expect(page).to have_content(old_goal.title)
            click_button "Delete"
            expect(page).not_to have_content(old_goal.title)
            expect(page).to have_content "Goal Deleted!"
        end
        scenario "deletes from goal page" do 
            visit goal_url(old_goal)
            click_button "Delete Goal"
            expect(page).not_to have_content(old_goal.title)
            expect(page).to have_content "Goal Deleted!"
        end
    end
end
