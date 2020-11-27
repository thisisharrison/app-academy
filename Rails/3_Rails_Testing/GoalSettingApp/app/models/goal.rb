class Goal < ApplicationRecord
    validates :title, presence: true
    validates :private, inclusion: { in: [true, false ] }
    validates :completed, inclusion: { in: [true, false ] }

    belongs_to :author, 
        class_name: :User,
        primary_key: :id, 
        foreign_key: :user_id

    has_many :comments, :as => :commentable

    has_many :cheers

    def cheered_by?(user)
        cheers.exist?(giver_id: user.id)
    end
end
