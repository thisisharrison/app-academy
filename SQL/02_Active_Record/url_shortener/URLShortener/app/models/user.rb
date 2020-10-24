class User < ApplicationRecord
    validates :email, uniqueness: true, presence: true

    has_many :submitted_urls,
        primary_key: :id,
        foreign_key: :submitter_id,
        class_name: :ShortenedUrl

    has_many :visits,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :Visit

    has_many :visited_urls,
        -> { distinct },
        through: :visits,
        # Visit::shortened_url calls the ShortenedUrl that belongs_to the visit
        source: :shortened_url

end

# Notes:
# Validation works:
# user = User.new
# user.valid? => false
# user.save! => ActiveRecord::RecordInvalid: Validation failed: Email can't be blank