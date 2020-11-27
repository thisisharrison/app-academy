class SessionsController < ApplicationController
    def new
        render :new
    end

    def create
        @user = User.find_by_credentials(*user_params.values)

        if @user
            log_in_user!(@user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = ['Incorrect credentials']
            render :new
        end
    end

    def destroy
        log_out_user!
        redirect_to new_session_url
    end

    private 
    def user_params
        params.require(:user).permit(:email, :password)
    end
end
