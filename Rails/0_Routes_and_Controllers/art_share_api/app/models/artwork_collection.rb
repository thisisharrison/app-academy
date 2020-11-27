class ArtworkCollection < ApplicationRecord
    # this validates collection_id and artwork_id
    belongs_to :collection
    belongs_to :artwork
end
