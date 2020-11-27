class Track < ApplicationRecord
    validates :title, :ord, presence: true
    validates :ord, numericality: { greater_than_or_equal_to: 1 }
    validates :bonus, inclusion: { in: [true, false] }
    validates :ord, uniqueness: { scope: :album_id }

    belongs_to :album
    
    has_one :band,
        through: :album,
        source: :band

    after_initialize :set_default

    has_many :notes,
        dependent: :destroy

    def set_default
        self.bonus ||= false
    end
end
