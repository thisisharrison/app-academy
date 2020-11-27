class User < ApplicationRecord
    validates :email, :password_digest, :session_token, :activation_token, presence: true
    validates :email, :session_token, :activation_token, uniqueness: true
    validates :password, length: { minimum: 6, allow_nil: true }
    validates :activated, inclusion: { in: [true, false] }
    
    after_initialize :ensure_session_token, :set_activation_token

    has_many :notes,
        dependent: :destroy

    attr_reader :password

    def self.generate_session_token
        SecureRandom::urlsafe_base64
    end

    def self.find_by_credentials(email, password)
        user = User.find_by(email: email)
        # user is not nil and password is correct, return user
        user && user.is_password?(password) ? user : nil
    end

    def reset_session_token!
        self.session_token = User.generate_session_token
        self.save!
        self.session_token
    end

    def ensure_session_token
        self.session_token ||= User.generate_session_token
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def set_activation_token
        self.activation_token ||= User.generate_session_token
    end 

    def activate!
        self.update_attribute(:activated, true)
    end
end
