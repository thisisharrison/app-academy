class ArtworkSharesController < ApplicationController
    # POST /artwork_shares
    # ["Artwork has already been taken"] if shared an artwork more than once to share user
    def create
        share = ArtworkShare.new(artwork_share_params)
        if share.save
            render json: share
        else
            render json: share.errors.full_messages, status: :unprocessable_entity
        end
    end

    # DELETE /artwork_shares/:id
    # unsharing an artwork with a user 
    def destroy
        share = ArtworkShare.find(params[:id])
        share.destroy
        render json: share
    end

    # POST   /artwork_shares/:id/favourite
    def favourite
        artwork_share = ArtworkShare.find_by(id: params[:id], viewer_id: params[:user_id])
        artwork_share.favourite = true
        artwork_share.save
        render json: artwork_share
    end

    # POST   /artwork_shares/:id/unfavourite
    def unfavourite
        artwork_share = ArtworkShare.find_by(id: params[:id], viewer_id: params[:user_id])
        artwork_share.favourite = false
        artwork_share.save
        render json: artwork_share
    end

    private
    def artwork_share_params
        # favourite is managed in favourite method 
        params.require(:artwork_share).permit(:artwork_id, :viewer_id)
    end
end
