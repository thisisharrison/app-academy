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
        visit user_url(demo_user)
    }

    shared_examples "comment" do 
        scenario "should have form for new comment" do
            expect(page).to have_content("New Comment")
            # have_field checks input field name (does it check type submit's value)
            expect(page).to have_field("Comment") 
        end 
        scenario "should save the new comment" do
            fill_in "comment_body", with: "first comment"
            click_button "Comment"
            expect(page).to have_content "first comment"
        end
    end

    describe "comment on profile show page" do
        # execute the above example
        it_behaves_like "comment" 
    end

    describe "comment on goal show page" do
        before(:each) { click_on goal.title }
        it_behaves_like "comment"
    end

end