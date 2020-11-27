class Collection < ApplicationRecord
    validates :name, presence: true
    # this will validate user_id
    belongs_to :user

    has_many :artwork_collections,
        primary_key: :id, 
        foreign_key: :collection_id,
        class_name: :ArtworkCollection, 
        # should destroy ArtworkCollection if collection is destroyed. 
        # does not destroy Artwork
        dependent: :destroy

    has_many :artworks,
        through: :artwork_collections,
        # ArtworkCollection#artwork
        source: :artwork
end
