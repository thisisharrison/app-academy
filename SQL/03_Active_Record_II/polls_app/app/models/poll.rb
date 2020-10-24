class Poll < ApplicationRecord
    # validates :title, :author, presence: true
    validates :title, presence: true
    # Rails 5 validates the presence of belongs_to association

    belongs_to :author,
        primary_key: :id,
        foreign_key: :author_id,
        class_name: :User

    has_many :questions,
        primary_key: :id,
        foreign_key: :poll_id,
        class_name: :Question,
        dependent: :destroy

end
