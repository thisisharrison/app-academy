class Sub < ApplicationRecord
    include Votable

    validates :title, presence: true, uniqueness: true

    # inverse will allow
    # User.subs.new to be valid when User is not saved (ie. ID is nil)
    belongs_to :moderator,
        foreign_key: :moderator_id, 
        class_name: :User,
        inverse_of: :subs

    has_many :post_subs,
        dependent: :destroy,
        # What will this do
        inverse_of: :sub
    
    # created Sub#post_ids=
    has_many :posts, 
        through: :post_subs,
        source: :post

end
