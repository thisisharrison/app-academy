class SessionsController < ApplicationController
    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.find_by_credentials(*user_params.values)
        if @user
            login!(@user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = ['Invalid Credentials']
            render :new
        end
    end

    def destroy
        logout!(current_user)
        redirect_to new_session_url
    end

    private
    def user_params
        params.require(:user).permit(:username, :password)
    end
end