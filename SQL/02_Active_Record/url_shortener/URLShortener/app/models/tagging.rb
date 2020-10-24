class Tagging < ApplicationRecord
    # Lesson learned! Use class name in validates. Check the presence of associated objects (TagTopic)
    validates :tag_topic, :shortened_url, presence: true
    
    # mirrors: add_index :taggings, [:tag_id, :shortened_url_id], unique: true
    # scope => specified attribute used to limit the uniqueness check
    validates :shortened_url_id, uniqueness: { scope: :tag_topic_id }

    # Above validation checks if object exists, so we also need belongs_to
    belongs_to :tag_topic,
        primary_key: :id,
        foreign_key: :tag_topic_id,
        class_name: :TagTopic
    
    belongs_to :shortened_url,
        primary_key: :id,
        foreign_key: :shortened_url_id,
        class_name: :ShortenedUrl,
        dependent: :destroy

end
