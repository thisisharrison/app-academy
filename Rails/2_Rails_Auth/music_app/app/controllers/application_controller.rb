class ApplicationController < ActionController::Base
    
    helper_method :log_in_user!, :logged_in?, :current_user, :current_user_id, :require_user!

    def log_in_user!(user)
        @user.reset_session_token!
        session[:session_token] = @user.session_token
    end

    def logged_in?
        # if current_user returns a user, !current_user = false, !false = true
        !!current_user
    end 

    def log_out_user!
        current_user.reset_session_token!
        session[:session_token] = nil
    end

    def current_user
        return nil if session[:session_token].nil?
        # Only query if we haven't set it 
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def current_user_id
        current_user ? current_user.id : nil
    end

    def require_user!
        redirect_to new_session_url if current_user.nil?
    end
end
