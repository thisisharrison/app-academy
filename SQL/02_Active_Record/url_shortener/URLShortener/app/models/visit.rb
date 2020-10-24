class Visit < ApplicationRecord
    validates :shortened_url, :visitor, presence: true

    # primary key, foreign key and class name follows convention
    # we can use short-hand...

    # Will be used in User::visited_urls
    belongs_to :shortened_url
    
    # Normal:
    # belongs_to :shortened_url,
    #     primary_key: :id,
    #     foreign_key: :shortened_url_id,
    #     class_name: :ShortenedUrl

    # Will be used in ShortenedUrl::visitors
    belongs_to :visitor,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :User

    # Takes User and ShortenedUrl objects, access their IDs in this factory method
    def self.record_visit!(user, shortened_url)
        Visit.create!(
            user_id: user.id,
            shortened_url_id: shortened_url.id
        )
    end

end
