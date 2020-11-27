class AddFavouriteToArtworksAndArtworkShares < ActiveRecord::Migration[5.2]
  def change
    add_column :artworks, :favourite, :boolean, default: false
    add_column :artwork_shares, :favourite, :boolean, default: false
  end
end
