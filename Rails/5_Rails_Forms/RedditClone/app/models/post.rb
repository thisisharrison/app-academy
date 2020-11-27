class Post < ApplicationRecord
    include Votable

    validates :title, :content, presence: true
    validates :subs, presence: { message: 'must have at least one sub'}
    
    belongs_to :author,
        class_name: :User,
        primary_key: :id,
        foreign_key: :author_id
        

    has_many :post_subs, 
        dependent: :destroy,
        # what will this do
        inverse_of: :post 
    
    # created Post#sub_ids=
    has_many :subs,
        through: :post_subs, 
        source: :sub

    has_many :comments, 
        inverse_of: :post

    # has_many :votes, as: :votable
    
    # N+1 Query Approach and O(n^2)
    def top_level_comments
        self.comments.where(parent_comment_id: nil).includes(:author)
    end

    # O(1) Approach
    def comments_in_hash
        all_comments = Hash.new { |h, k| h[k] = [] }
        self.comments.includes(:author).each do |comment| 
            all_comments[comment.parent_comment_id] << comment
            
        end
        all_comments
    end
end