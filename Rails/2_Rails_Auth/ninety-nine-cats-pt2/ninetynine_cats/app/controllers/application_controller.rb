class ApplicationController < ActionController::Base
    # With this, expose these methods to views
    helper_method :current_user
    helper_method :logged_in?

    private
    
    def current_user
        return nil unless session[:session_token]
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def login_user!(user)
        session[:session_token] = user.reset_session_token!
    end

    def logout_user!(user)
        current_user.reset_session_token!
        session[:session_token] = nil
    end

    def logged_in?
        # if current_user not nil, user is logged in
        !current_user.nil?
    end

    def require_no_user!
        return if current_user.nil?
        redirect_to cats_url
        # or
        # redirect_to cats_url if current_user
    end

    def require_user!
        redirect_to new_session_url if current_user.nil?
    end

    
end
