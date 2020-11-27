require 'rails_helper'
require 'byebug'

RSpec.describe UsersController, type: :controller do

    subject(:user) do 
        User.create!(username: 'dummyuser', password: 'goodpassword')
    end

    describe "GET #show" do 
        before do
            allow(controller).to receive(:current_user) { user }
        end    
        it "renders the show template" do     
            get :show, params: {id: user.id}
            expect(response).to render_template(:show)
        end
    end
    
    describe "GET #index" do 
        it "renders the index template" do 
            get "index"
            expect(response).to render_template(:index)
        end
    end

    describe "POST #create" do 
        context "with invalid params" do
            it "validates presence of username and password" do
                post "create", params: {user: {username: "baduser", password: ""}}
                expect(response).to render_template(:new)
                expect(flash[:errors]).to be_present
            end
            it "validates length of password" do 
                post "create", params: {user: {username: "baduser", password: "123"}}
                expect(response).to render_template(:new)
                expect(flash[:errors]).to be_present
            end
        end
        
        context "with valid params" do 
            it "redirects to show page" do 
                post "create", params: {user: {username: "gooduser", password: "goodpassword"}}
                expect(response).to redirect_to(user_url(User.last))
            end
        end
    end    

end
