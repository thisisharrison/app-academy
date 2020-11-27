class SessionsController < ApplicationController
    
    before_action :require_no_user!, only: [:create, :new]
    
    def new
        render :new
    end

    def create
        # user_params method is hash key and value pairs 
        # #values to get values 
        # * to unpack args
        user = User.find_by_credentials(*user_params.values)
        if user.nil?
            flash.now[:errors] = ['Incorrect username and/or password']
            render :new
        else
        
            # refactor below to application_controller
            # user.reset_session_token!
            # session[:session_token] = user.session_token
            login_user!(user)
            redirect_to cats_url
        end
    end

    def destroy
        # refactor beflow to applicatino_controller
        # if current_user
        #     current_user.reset_session_token!
        #     session[:session_token] = nil
        # end
        logout_user!(current_user)
        # redirect to login form
        redirect_to new_session_url
    end

    private
    def user_params
        params.require(:user).permit(:user_name, :password)
    end
end