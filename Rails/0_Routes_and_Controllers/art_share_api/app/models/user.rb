class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true

    has_many :artworks,
        primary_key: :id,
        foreign_key: :artist_id,
        class_name: :Artwork,
        dependent: :destroy

    has_many :artwork_shares, 
        primary_key: :id, 
        foreign_key: :viewer_id, 
        class_name: :ArtworkShare,
        dependent: :destroy

    has_many :shared_artworks,
        through: :artwork_shares,
        source: :artwork

    has_many :comments,
        primary_key: :id,
        foreign_key: :user_id, 
        class_name: :Comment,
        dependent: :destroy

    # only need as: :likeable for the likeable_types: artwork and comment
    # this is for Like#belongs_to :user  
    has_many :likes

    # These just return Like objects
    # def liked_artworks
    #     likes.where('likeable_type = ?', 'Artwork')
    # end

    # def liked_comments
    #     likes.where('likeable_type = ?', 'Comment')
    # end

    # These return Artwork and Comment objects
    has_many :liked_artworks,
        through: :likes,
        source: :likeable,
        source_type: :Artwork
    
    has_many :liked_comments,
        through: :likes,
        source: :likeable,
        source_type: :Comment

    has_many :collections
    
    def favourite_artworks
        artworks.where(favourite: true)
    end

    def favourite_shared_artworks
        shared_artworks.where(favourite: true)
    end
end
