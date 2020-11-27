class CommentsController < ApplicationController
    def create
        @comment = Comment.new(comment_params)
        @comment.author_id = current_user_id
        
        if @comment.save
            flash[:notices] = ['Comment Saved!']
        else
            flash[:errors] = @comment.errors.full_messages
        end
        
        # Redirects the browser to the page that issued the request (the referrer) if possible, otherwise redirects to the provided default fallback location.
        redirect_back(fallback_location: root_url)
    end

    private
    def comment_params
        params.require(:comment).permit(:body, :commentable_type, :commentable_id)
    end
end
