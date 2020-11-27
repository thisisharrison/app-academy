class Vote < ApplicationRecord
    validates :value, inclusion: { in: [-1, 1] }
    validates :user_id, uniqueness: { scope: [:votable_type, :votable_id], message: 'can only vote once' }
    
    belongs_to :user, inverse_of: :votes
    belongs_to :votable, polymorphic: true
end