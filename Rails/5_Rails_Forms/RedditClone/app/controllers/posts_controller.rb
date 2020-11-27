class PostsController < ApplicationController
    before_action :require_sign_in!, except: [:show]
    before_action :require_post_owner!, only: [:edit, :update]
    
    def show
        @post = Post.find(params[:id])
        @vote = current_user.votes.find_or_initialize_by(user: current_user, votable_type: 'Post', votable_id: params[:id])
    end

    def new
        @post = Post.new
    end

    def create
        @post = current_user.posts.new(post_params)
        
        if @post.save
            flash[:notices] = ['Post created!']
            redirect_to post_url(@post)
        else
            flash[:errors] = @post.errors.full_messages
            render :new
        end
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])
        if @post.update(post_params)
            flash[:notices] = ['Post updated!']
            redirect_to post_url(@post)
        else
            flash[:errors] = @post.errors.full_messages
            render :new
        end
    end

    def downvote
        vote('Post',-1)
    end

    def upvote
        vote('Post',1)
    end

    private
    def post_params
        # this will create sub_ids array
        # resulting in, current_user.post.new(title:..., sub_ids:[...])
        # then it creates the post_sub when saved
        params.require(:post).permit(:title, :content, :url, sub_ids: [])
    end

    def require_post_owner!
        return if current_user.posts.find_by(id: params[:id])
        flash[:errors] = ['Only post owner can edit']
        redirect_back(fallback_location: post_url(@post))
    end
end
