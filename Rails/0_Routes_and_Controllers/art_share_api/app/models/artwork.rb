class Artwork < ApplicationRecord
    validates :title, :artist, :image_url, presence: true
    validates :image_url, uniqueness: true
    validates :title, uniqueness: {scope: :artist_id}
    validates :favourite, inclusion: { in: [true, false] }

    belongs_to :artist,
        primary_key: :id,
        foreign_key: :artist_id,
        class_name: :User

    has_many :artwork_shares,
        primary_key: :id, 
        foreign_key: :artwork_id,
        class_name: :ArtworkShare

    has_many :shared_viewers,
        through: :artwork_shares,
        source: :viewer

    has_many :comments,
        primary_key: :id, 
        foreign_key: :artwork_id,
        class_name: :Comment,
        dependent: :destroy

    has_many :likes, as: :likeable

    # has_many :liked_users,
    #     through: :likes,
    #     source: :likeable,
    #     primary_key: :id,
    #     foreign_key: :user_id,
    #     class_name: :User

    has_many :liked_users,
        through: :likes,
        source: :user

    has_many :artwork_collections

    # artwork owned by AND shared with user_id
    def self.artworks_for_user_id(user_id)
        Artwork.left_outer_joins(:artwork_shares)
                .where('(artwork_shares.viewer_id = :user_id) OR (artworks.artist_id = :user_id)', user_id: user_id)
                .distinct
    end

    # replaced with has_many! 
    # def liked_users
    #     User.where('users.id IN (?) ',self.likes.pluck(:user_id))
    # end
end
