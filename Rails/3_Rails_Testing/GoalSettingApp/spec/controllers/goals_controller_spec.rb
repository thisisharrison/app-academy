require 'rails_helper'
require 'byebug'

RSpec.describe GoalsController, type: :controller do
    let(:user) do
        User.create!(username: 'dummyuser', password: 'goodpassword')
    end

    describe "GET #new" do 
        context 'when logged in' do
            before do
                allow(controller).to receive(:current_user) { user }
            end

            it 'renders the new Goals page' do
                get "new"
                expect(response).to render_template(:new)
            end
        end

        context 'when logged out' do
            before do
                allow(controller).to receive(:current_user) { nil }
            end

            it 'redirects to the login page' do
                get "new"
                expect(response).to redirect_to(new_session_url)
            end
        end
    end

    describe "POST #create" do
        context "when logged out" do
            before do 
                allow(controller).to receive(:current_user) { nil }
            end    
            
            it "redirects to login page" do 
                post "create", params: { goal: {title: 'hacker'} }
                expect(response).to redirect_to(new_session_url)
            end
        end

        context "when logged in" do
            before do 
                allow(controller).to receive(:current_user) { user }
            end

            context "with invalid params" do
                it "validates params and renders new" do 
                    post "create", params: { goal: {title: ''} }
                    expect(response).to render_template(:new)
                    expect(flash[:errors]).to be_present
                end
            end
            
            context "with valid params" do
                it "redirects to show page" do
                    post "create", params: { goal: {title: 'goodboi'} }
                    expect(response).to redirect_to(goal_url(Goal.last))
                    expect(flash[:notices]).to be_present
                end
            end
        end
    end
end
