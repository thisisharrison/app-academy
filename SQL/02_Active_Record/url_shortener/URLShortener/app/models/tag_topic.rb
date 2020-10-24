class TagTopic < ApplicationRecord
    validates :name, presence: true

    # A topic can be tagged many times
    has_many :taggings,
        primary_key: :id,
        foreign_key: :tag_topic_id,
        class_name: :Tagging

    # returns array of ShortenedUrls 
    has_many :shortened_urls,
        through: :taggings,
        # Tagging#shortened_url
        source: :shortened_url
    
    # will need above shortened_url link
    def popular_links
        # TagTopic class (a specific topic) - shortened_urls 
        links = shortened_urls.joins(:visits)
            .group(:id)
            .order('COUNT(visits.id) DESC')
            .select('long_url, short_url, COUNT(visits.id) AS num_of_clicks')
            .limit(5)

        links.map do |link|
            [link.long_url, link.short_url, link.num_of_clicks]
        end
    end
end
