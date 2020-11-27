class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true 
    validates :session_token, presence: true, uniqueness: true 
    validates :password_digest, presence: { message: 'Password can\'t be blank' }
    
    # Validates password uses attr_reader
    validates :password, length: { minimum: 6, allow_nil: true }

    before_validation :ensure_session_token

    # For validation to occur we need attr_reader for @password
    attr_reader :password

    def self.generate_session_token
        SecureRandom::urlsafe_base64(16)
    end

    def self.find_by_credentials(username, pw)
        user = User.find_by(
            username: username
        )
        # Checks with bcrypt if is_password?, return user else nil
        user.is_password?(pw) ? user : nil
    end

    def is_password?(pw)
        BCrypt::Password.new(self.password_digest).is_password?(pw)
    end

    def reset_session_token!
        # Overwrite existing token
        self.session_token = User.generate_session_token
        self.save!

        self.session_token
    end

    def ensure_session_token
        # Returns token if token exists (true) else generates
        self.session_token ||= User.generate_session_token
    end

    # attr_writer
    def password=(pw)
        @password = pw
        self.password_digest = BCrypt::Password.create(pw)
    end

    

end

# Notes:
# Password
# To validate password (length), we need attr_reader 
# To use attr_reader, we need instance variable @password
# TO write to this variable, we need attr_reader password=(pw)
# We also create the password_digest which we save to DB