class SessionsController < ApplicationController
    before_action :require_sign_in!, only: [:destroy]

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.find_by_credentials(*user_params.values)

        if @user
            login(@user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = ['Invalid credentials']
            render :new
        end
    end

    def destroy
        logout
        redirect_to new_session_url
    end

    private 
    def user_params
        params.require(:user).permit(:name, :password)
    end
end
