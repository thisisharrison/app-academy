require 'spec_helper'
require 'rails_helper'


feature 'the privacy settings of goals' do
    given!(:demo_user) { FactoryBot.create(:user) }
    given!(:guest_user) { FactoryBot.create(:user) }
    given!(:public_goal) { FactoryBot.create(:goal, author: demo_user) }
    given!(:private_goal) { FactoryBot.create(:goal, author: demo_user, private: { privacy: true }) }
    
    describe "public goals" do
    
        scenario "show public goals in show when logged out" do 
            visit goal_url(public_goal)
            expect(page).to have_content(public_goal.title)
        end

        scenario "allows other people see public goals" do 
            login(guest_user)
            visit goal_url(public_goal)
            expect(page).to have_content(public_goal.title)
        end
    
    end

    describe "private goals" do 

        scenario "hides private goals in show when logged out" do 
            visit goal_url(private_goal)
            expect(page).to have_content "Sign Up"
        end

        scenario "hides private goals from other people" do 
            login(guest_user)
            visit goal_url(private_goal)
            expect(page).to have_content "Secret Goal"
        end

    end
end