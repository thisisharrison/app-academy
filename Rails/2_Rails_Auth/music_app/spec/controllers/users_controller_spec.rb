require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    describe "GET #new" do
    it "renders the new template" do
        get :new, {}
        expect(response).to render_template("new")
    end
    end

    describe "POST #create" do
        context "with invalid params" do
            it "validates the presence of the user's email and password" do
                # http method, params
                post :create, params: {user: {email: '', password: 'uhoh'}}
                # response and rendering
                expect(response).to render_template("new")
                expect(flash[:errors]).to be_present
            end

            it "validates that the password is at least 6 characters long" do 
                # http method, params
                post :create, params: {user: {email: 'testing@example.com', password: 'uhoh'}}
                # response and rendering
                expect(response).to render_template("new")
                expect(flash[:errors]).to be_present
            end
        end

        context "with valid params" do
            it "redirects user to sign in page on success" do
                # http method, params
                post :create, params: {user: {email: 'testing@example.com', password: 'goodpassword'}}
                # response and rendering
                expect(response).to redirect_to(new_session_url)
            end
        end
    end
    
end
