class Comment < ApplicationRecord
    include Votable

    validates :content, presence: true

    after_initialize :ensure_post_id!

    belongs_to :author,
        class_name: :User,
        foreign_key: :author_id
    
    belongs_to :post, 
        inverse_of: :comments
    
    # parent comment does not have a parent comment id
    # so optional: true = allow nil foreign_key
    belongs_to :parent_comment,
        class_name: :Comment,
        primary_key: :id, 
        foreign_key: :parent_comment_id,
        optional: true

    has_many :child_comments,
        class_name: :Comment,
        primary_key: :id,
        foreign_key: :parent_comment_id

    # has_many :votes, as: :voteable

    private
    def ensure_post_id!
        self.post_id ||= self.parent_comment.post_id if parent_comment
    end
end
