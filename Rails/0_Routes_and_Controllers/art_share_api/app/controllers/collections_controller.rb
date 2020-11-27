class CollectionsController < ApplicationController
    def index
        # GET /users/:id/collections
        collection = Collection.where(user_id: params[:user_id])
        render json: collection
    end

    def show
        # GET /collections/:id
        collection = Collection.find(params[:id])
        render json: collection
    end

    def create
        # POST /collections
        collection = Collection.new(collection_params)
        if collection.save
            render json: collection
        else
            render json: collection.errors.full_messages, status: :unprocessable_entity
        end
    end

    def destroy
        # DELETE /collections/:id
        collection = Collection.find(params[:id])
        collection.destroy
        render json: collection
    end

    def add_artwork
        # POST /collections/:collection_id/artworks/:artwork_id/add
        artwork_collection = ArtworkCollection.new(artwork_collection_params)
        if artwork_collection.save
            render json: artwork_collection
        else
            render json: artwork_collection.errors.full_messages, stats: :unprocessable_entity
        end
    end

    def remove_artwork
        # DELETE /collections/:collection_id/artworks/:artwork_id/remove
        artwork_collection = ArtworkCollection.find_by(artwork_collection_params)
        artwork_collection.destroy
        render json: artwork_collection
    end

    private
    def collection_params
        params.require(:collection).permit(:user_id, :name)
    end

    def artwork_collection_params
        { collection_id: params[:collection_id], artwork_id: params[:artwork_id] }
    end
end
