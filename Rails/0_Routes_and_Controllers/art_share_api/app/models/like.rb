class Like < ApplicationRecord
    validates :user_id, uniqueness: { scope: [:likeable_id, :likeable_type] }

    # i.e. belongs_to artwork and comment
    belongs_to :likeable, polymorphic: true
    
    belongs_to :user
end
