class Comment < ApplicationRecord
    # validates :artwork, :user

    belongs_to :artwork
    belongs_to :author, 
        primary_key: :id, 
        foreign_key: :user_id,
        class_name: :User

    has_many :likes, as: :likeable

    has_many :liked_users,
        through: :likes, 
        source: :user
end
