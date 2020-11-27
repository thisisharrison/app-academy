class CommentsController < ApplicationController
    def index
        case 
        #  GET    /users/:user_id/comments
        when params[:user_id]
            user = User.find(params[:user_id])
            comments = user.comments
        # GET    /artworks/:artwork_id/comments
        when params[:artwork_id]
            artwork = Artwork.find(params[:artwork_id])
            comments = artwork.comments
        else
            comments = Comment.all
        end
        
        render json: comments
    end
    
    # POST   /comments
    def create
        comment = Comment.new(comments_params)
        if comment.save
            render json: comment
        else
            render json: comment.errors.full_messages, status: :unprocessable_entity
        end
    end
    
    # DELETE /comments/:id
    def destroy
        comment = Comment.find(params[:id])
        comment.destroy
        render json: comment
    end

    # POST /comments/:id/like
    def like
        like = Like.new(likes_params)
        if like.save
            render json: like
        else
            render json: like.errors.full_messages, status: :unprocessable_entity
        end
    end

    # POST /comments/:id/unlike
    def unlike
        like = Like.find_by(likes_params)
        like.destroy
        render json: like
    end

    private 
    def comments_params
        params.require(:comment).permit(:user_id, :artwork_id, :body)
    end

    def likes_params
        {user_id: params[:user_id], likeable_id: params[:id], likeable_type: 'Comment'}
        # user_id: ? in x-www-form-encoded
    end
end
