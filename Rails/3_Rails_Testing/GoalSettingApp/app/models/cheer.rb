class Cheer < ApplicationRecord

    CHEER_LIMIT = 12
    CHEER_LIMIT.freeze

    belongs_to :giver,
        class_name: :User,
        foreign_key: :giver_id

    belongs_to :goal

    # scope to limit uniqueness check
    # goal + giver match should be unique
    validates :goal_id, uniqueness: { scope: :giver_id }

end
