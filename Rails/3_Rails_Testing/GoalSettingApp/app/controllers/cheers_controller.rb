class CheersController < ApplicationController   
    def index
        @cheer = current_user_id.cheers_received
    end

    def create
        if current_user.exceed_cheer_limit?
            flash[:errors] << ['Exceeded Your Limit']
            redirect_back(fallback_location: root_url)
        end

        @cheer = Cheer.new(giver_id: current_user_id, goal_id: params[:goal_id])

        if @cheer.save
            current_user.decrement_cheer_count!
            goal_owner = Goal.find(params[:goal_id]).author.username
            flash[:notices] = ["You cheered #{goal_owner}'s goal!"]
        else
            flash[:errors] = @cheer.errors.full_messages
        end
        redirect_back(fallback_location: root_url)
    end

end
