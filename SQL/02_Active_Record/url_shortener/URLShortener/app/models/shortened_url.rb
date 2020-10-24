class ShortenedUrl < ApplicationRecord
    # validates :long_url, presence: true
    # validates :short_url, presence: true, uniqueness: true
    # validates :submitter, presence: true

    validates :long_url, :short_url, :submitter, presence: true
    validates :short_url, uniqueness: true

    # method created for custom validation and error
    validate :no_spamming, :nonpremium_max

    # a url belongs to a submitter
    belongs_to :submitter,
        primary_key: :id,
        foreign_key: :submitter_id,
        class_name: :User

    has_many :visits,
        primary_key: :id,
        foreign_key: :shortened_url_id,
        class_name: :Visit,
        # cascade: foreign key if deleted, destroy Visit
        dependent: :destroy

    # has_many through => can traverse other associations (Visit) to get to User using :visitor
    has_many :visitors,
        # Need the above visits method to tie to Visit
        -> { distinct },
        through: :visits,
        # calls Visit.visitor and return User object
        source: :visitor
    
    # a url has many taggings
    has_many :taggings,
        primary_key: :id,
        foreign_key: :shortened_url_id,
        class_name: :Tagging,
        dependent: :destroy
    
    # has many taggings, which has topics 
    has_many :tag_topics,
        through: :taggings,
        # the source = tag_topic method in Tagging Class
        source: :tag_topic
    
    def self.random_code
        # repeat until rand_code does not exist in short_url
        # return rand_code if unique
        loop do
            rand_code = SecureRandom.urlsafe_base64
            return rand_code unless ShortenedUrl.exists?(short_url: rand_code)
        end
    end

    # Factory method that takens user object and call random_code when create!
    def self.create_for_user!(user, long_url)
        ShortenedUrl.create!(
            long_url: long_url,
            short_url: ShortenedUrl.random_code,
            submitter_id: user.id
        )
    end

    def self.prune(n)
        ShortenedUrl
            .joins(:submitter)
            .joins("LEFT JOIN visits ON visits.shortened_url_id = shortened_urls.id")
            .where("(shortened_urls.id IN (
                SELECT shortened_urls.id 
                FROM shortened_urls
                JOIN visits
                ON shortened_urls.id = visits.shortened_url_id
                GROUP BY shortened_urls.id
                HAVING MAX(visits.created_at) < '#{n.minutes.ago}')
                OR 
                (visits.id IS NULL AND shortened_urls.created_at < '#{n.minutes.ago}'))
                AND 
                users.premium = 'f'
            ").destroy_all
        
            # WHERE NOTES:
            # (1) urls older than n minutes that have not been visited in last (n) minutes 
            # (urls.created_at AND visits.id IS NULL)
            # (2) urls have not been visited in last n minutes
            # (use MAX to find the most recent visit)
            # (3) users premium is false
    end

    def num_clicks
        visits.count
    end

    def num_uniques
        # without -> {distinct}
        # can use visitors.select('user_id').distinct.count
        visitors.count
    end

    def num_recent_uniques
        visits
            .select('user_id')
            .where("created_at > ?", 10.minutes.ago)
            .distinct
            .count
    end

    private
    
    def no_spamming
        # the urls submitted in the last minute
        # the urls from this submitted_id
        # count how many
        
        count = ShortenedUrl.where("created_at >= ?", 1.minutes.ago).where(submitter_id: submitter_id).length
        errors[:maximum] << "1 url per minute reached" if count >= 5 
        
        # Output:
        # Validation failed: Maximum 1 url per minute reached
    end

    def nonpremium_max
        # submitter returns User, User.premium returns true or false
        return if self.submitter.premium

        count = ShortenedUrl.where(submitter_id: submitter_id).length
        errors[:nonpremium] << "members can only submit up to 5 urls" if count >= 5

        # Output:
        # Nonpremium members can only submit up to 5 urls
    end
end

# Note:
# ShortenedUrl::visitors
# -> {distinct}
# SELECT DISTINCT "users".* 
# FROM "users" 
# INNER JOIN "visits" ON "users"."id" = "visits"."user_id" 
# WHERE "visits"."shortened_url_id" = $1 

# ShortenedUrl#num_recent_uniques
# SELECT COUNT(DISTINCT "visits"."user_id") 
# FROM "visits" 
# WHERE "visits"."shortened_url_id" = $1 
# AND (created_at > '2020-10-11 14:18:07.581664')  

# ShortenedUrl#tag_topics
# SELECT "tag_topics".* FROM "tag_topics" 
# INNER JOIN "taggings" ON "tag_topics"."id" = "taggings"."tag_topic_id" 
# WHERE "taggings"."shortened_url_id" = $1[0m  [["shortened_url_id", 1]]