class ArtworkShare < ApplicationRecord
    # Rails 5 will validate with belongs_to 
    # validates :artwork, :viewer, presence: true

    validates :artwork_id, uniqueness: { scope: :viewer_id }
    validates :favourite, inclusion: { in: [true, false] }

    belongs_to :artwork,
        primary_key: :id,
        foreign_key: :artwork_id,
        class_name: :Artwork
    
    belongs_to :viewer, 
        primary_key: :id,
        foreign_key: :viewer_id,
        class_name: :User

    
end
