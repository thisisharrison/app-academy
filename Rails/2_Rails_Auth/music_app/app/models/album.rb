class Album < ApplicationRecord
    validates :band, :title, :year, presence: true
    validates :live, inclusion: { in: [true, false] }
    
    # CHECK
    validates :title, uniqueness: { scope: :band_id }
    # validates :band, :title, uniqueness: true

    belongs_to :band

    has_many :tracks,
        dependent: :destroy
end
