class ArtworksController < ApplicationController
    # 1. 
    def index
        # Method 1: User methods (3 queries)
        # user = User.find(params[:user_id])
        # art2 = (user.artworks + user.shared_artworks).uniq
        case 
        # GET /users/:user_id/artworks
        when params[:user_id]
            # Method 2: Artwork method (1 query)
            art = Artwork.artworks_for_user_id(params[:user_id])
            render json: art
        
        # GET /collections/:collection_id/artworks
        when params[:collection_id]
            art = Collection.find(params[:collection_id]).artworks
            render json: art 
        end
    end
    # 2. GET /:id
    def show
        render json: Artwork.find(params[:id])
    end
    # 3. POST
    def create
        artwork = Artwork.new(artwork_params)
        if artwork.save
            render json: artwork
        else
            render artwork.errors.full_messages, status: :unprocessable_entity
        end
    end
    # 4. PATCH /:id
    def update
        artwork = Artwork.find(params[:id])
        
        if artwork.update(artwork_params)
            render json: artwork
        else
            render artwork.errors.full_messages, status: :unprocessable_entity
        end
    end
    # 5. DELETE /:id
    def destroy
        artwork = Artwork.find(params[:id])
        artwork.destroy

        render json: artwork
    end

    # POST   /artworks/:id/like
    def like
        like = Like.new(likes_params)
        if like.save
            render json: like
        else
            render json: like.errors.full_messages, status: :unprocessable_entity
        end
    end

    # POST   /artworks/:id/unlike
    def unlike
        like = Like.find_by(likes_params)
        like.destroy
        render json: like
    end

    # POST   /artworks/:id/favourite
    def favourite
        # Only user can favourite their own artwork
        artwork = Artwork.find_by(id: params[:id], artist_id: params[:user_id])
        artwork.favourite = true
        artwork.save
        render json: artwork
    end

    # POST   /artworks/:id/unfavourite
    def unfavourite
        artwork = Artwork.find_by(id: params[:id], artist_id: params[:user_id])
        artwork.favourite = false
        artwork.save
        render json: artwork
    end

    private
    def artwork_params
        # favourite is managed in favourite method
        params.require(:artwork).permit(:title, :image_url, :artist_id)
    end

    def likes_params
        {user_id: params[:user_id], likeable_id: params[:id], likeable_type: 'Artwork'}
        # user_id: ? in x-www-form-encoded
    end
end
