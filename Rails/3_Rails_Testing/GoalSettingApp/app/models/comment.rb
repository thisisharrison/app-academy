class Comment < ApplicationRecord
    include Commentable
    
    belongs_to :author, 
        class_name: :User, 
        foreign_key: :author_id
    
    # Replaced by concerns commentable module
    # belongs_to :commentable, :polymorphic => true
    
end