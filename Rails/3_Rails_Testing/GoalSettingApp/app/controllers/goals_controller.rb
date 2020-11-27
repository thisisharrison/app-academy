class GoalsController < ApplicationController
    before_action :require_login!, except: [:show]

    def new
        @goal = Goal.new
    end
    
    def create
        @goal = current_user.goals.new(goal_params)
        if @goal.save
            flash[:notices] = ["Let's get it!"]
            redirect_to goal_url(@goal)
        else
            flash.now[:errors] = @goal.errors.full_messages
            render :new
        end
    end

    def show
        @goal = Goal.find(params[:id])
        if !@goal.private || @goal.user_id == current_user_id
            render :show 
        else
            flash[:errors] = ['Secret Goal']
            redirect_to goals_url
        end
    end

    def index
        @goals = current_user.goals.all
    end

    def edit
        @goal = Goal.find(params[:id])
        render :edit
    end

    def update
        @goal = Goal.find(params[:id])
        
        if @goal.update_attributes(goal_params)
            flash[:notices] = ["Goal Updated!"]
            redirect_to goal_url(@goal)
        else
            flash.now[:errors] = @goal.errors.full_messages
            render :edit
        end
    end

    def destroy
        @goal = Goal.find(params[:id])
        @goal.destroy
        flash[:notices] = ["Goal Deleted!"]
        redirect_to goals_url
    end

    def complete
        @goal = Goal.find(params[:id])
        @goal.completed = !@goal.completed
        @goal.save!
        flash[:notices] = ["Goal Complete!"] if @goal.completed
        redirect_to request.referer
    end

    private
    def goal_params
        params.require(:goal).permit(:title, :details, :private, :completed)
    end
end