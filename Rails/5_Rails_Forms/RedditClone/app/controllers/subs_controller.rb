class SubsController < ApplicationController
    before_action :require_sign_in!, except: [:index]
    before_action :require_sub_owner!, only: [:edit, :update]

    def index
        @subs = Sub.all
        render :index
    end

    def show
        @sub = Sub.find(params[:id])
        @vote = current_user.votes.find_or_initialize_by(user: current_user, votable_type: 'Sub', votable_id: params[:id])
        render :show
    end

    def new
        @sub = Sub.new
        render :new
    end

    def create
        @sub = current_user.subs.new(sub_params)

        if @sub.save
            flash[:notices] = ['Sub successfully created!']
            redirect_to sub_url(@sub)
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :new
        end
    end 

    def edit
        @sub = Sub.find(params[:id])
        render :edit
    end

    def update
        @sub = Sub.find(params[:id])
        
        if @sub.update(sub_params)
            flash[:notices] = ['Sub successfully updated!']
            redirect_to sub_url(@sub)
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :edit
        end
    end

    def downvote
        vote('Sub', -1)
    end

    def upvote
        vote('Sub', 1)
    end

    private
    def sub_params
        params.require(:sub).permit(:title, :description)
    end

    def require_sub_owner!
        return if current_user.subs.find_by(id: params[:id])
        flash[:errors] = ['Only moderators can edit sub']
        redirect_back(fallback_location: sub_url(@sub))
    end
end