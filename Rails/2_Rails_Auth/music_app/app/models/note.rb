class Note < ApplicationRecord
    validates :note, presence: true

    belongs_to :user

    belongs_to :track
    
end
