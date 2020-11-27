class User < ApplicationRecord
    validates :name, :session_token, presence: true
    validates :password_digest, presence: { message: 'Password can\'t be blank' }
    validates :session_token, uniqueness: true
    validates :password_digest, uniqueness: true
    validates :password, length: { minimum: 6, allow_nil: true }

    has_many :subs, 
        class_name: :Sub,
        foreign_key: :moderator_id,
        inverse_of: :moderator

    has_many :posts,
        class_name: :Post,
        foreign_key: :author_id

    has_many :comments, 
        class_name: :Comment, 
        foreign_key: :author_id
    
    has_many :votes,
        inverse_of: :user
    
    attr_reader :password

    after_initialize :ensure_session_token

    def self.generate_session_token
        begin
            token = SecureRandom::urlsafe_base64(16)
        end while User.exists?(session_token: token)
        token
    end

    def self.find_by_credentials(name, password)
        user = User.find_by(name: name)
        return nil if user.nil?
        user.is_password?(password) ? user : nil
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end
    
    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def reset_session_token!
        self.session_token = User.generate_session_token
        self.save!
        self.session_token
    end

    private

    def ensure_session_token
        self.session_token ||= User.generate_session_token
    end

end
