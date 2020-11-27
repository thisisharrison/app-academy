class ApplicationController < ActionController::Base
    helper_method :current_user, :signed_in?, :current_user_name, :current_user_id

    private 
    def login(user)
        session_token = user.reset_session_token!
        session[:session_token] = session_token
    end

    def logout
        current_user.reset_session_token!
        session[:session_token] = nil
    end

    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token]) 
    end

    def current_user_name
        @current_user.name if signed_in?
    end

    def current_user_id
        @current_user.id if signed_in?
    end

    def require_sign_in!
        redirect_to new_session_url unless signed_in?
    end

    def require_sign_out!
        redirect_to root_url if signed_in?
    end

    def signed_in?
        !!current_user
    end

    def vote(type, direction)
        @vote = current_user.votes.new(votable_type: type, votable_id: params[:id])
        @vote.value = direction
        if @vote.save
            flash[:notices] = ['You voted!']
            redirect_back(fallback_location: root_url)
        else
            flash[:errors] = @vote.errors.full_messages
            redirect_back(fallback_location: root_url)
        end
    end
end
