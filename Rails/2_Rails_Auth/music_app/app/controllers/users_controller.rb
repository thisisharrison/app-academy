class UsersController < ApplicationController
    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)

        if @user.save
            UserMailer.activation_email(@user).deliver_now!
            flash[:notices] = "Successfully created account. Check your inbox to activate."
            redirect_to new_session_url
            # log_in_user!(@user) 
            # redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def show
        @user = User.find(params[:id])
        render :show
    end

    def activate
        @user = User.find_by(activation_token: params[:activation_token])
        @user.activate!
        log_in_user!(@user)
        flash[:notices] = "Successfully activated account"
        redirect_to user_url(@user)
    end

    private
    def user_params
        params.require(:user).permit(:email, :password)
    end
end