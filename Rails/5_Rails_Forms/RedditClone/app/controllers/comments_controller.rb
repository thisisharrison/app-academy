class CommentsController < ApplicationController
    before_action :require_sign_in!

    def new
        @comment = Comment.new(post_id: params[:post_id]) 
    end

    def create
        @comment = current_user.comments.new(comment_params)
        if @comment.save
            flash[:notices] = ['Comment created!']
            redirect_to post_url(@comment.post_id)
        else
            flash[:errors] = @comment.errors.full_messages
            render :new
        end
    end

    def show
        # for showing comment 
        @comment = Comment.find(params[:id])
        # for replying the comment, fills in the parent_comment_id, and on initialize, fills in the post_id too
        @new_comment = @comment.child_comments.new
        @vote = current_user.votes.find_or_initialize_by(user: current_user, votable_type: 'Comment', votable_id: params[:id])
    end

    def downvote
        vote('Comment',-1)
    end

    def upvote
        vote('Comment',1)
    end

    private
    def comment_params
        params.require(:comment).permit(:post_id, :content, :parent_comment_id)
    end
end