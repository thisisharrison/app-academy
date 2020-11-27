class User < ApplicationRecord
    validates :user_name, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, length: { minimum: 6, allow_nil: true }

    after_initialize :ensure_session_token

    has_many :cats

    has_many :rental_requests, 
        class_name: :CatRentalRequest,
        primary_key: :id, 
        foreign_key: :user_id


    attr_reader :password

    def self.generate_session_token
        SecureRandom::urlsafe_base64(16)
    end

    def self.find_by_credentials(user_name, password)
        user = User.find_by(user_name: user_name)
        # nil cannot do is_password?, this line returns early to prevent error
        return nil if user.nil?
        user.is_password?(password) ? user : nil
    end

    def reset_session_token!
        self.session_token = User.generate_session_token
        self.save!
        self.session_token
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def owns_cat?(cat)
        cat.user_id == self.id
    end

    private
    def ensure_session_token
        self.session_token ||= User.generate_session_token
    end
end
