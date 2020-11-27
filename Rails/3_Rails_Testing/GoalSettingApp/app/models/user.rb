class User < ApplicationRecord
  include Commentable

  validates :username, 
            :session_token,
            :password_digest,
            presence: true
  # validates :password_digest, presence: { message: 'Password cannot be blank' }
  validates :username, uniqueness: true
  validates :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :cheer_count, numericality: { only_integer: true, minimum: 0 } 

  # after_initialize => only for after Active Record object is instantiated (#new)
  # before_validation => last chance to check before saving
  # after_initialize :ensure_session_token
  # after_initialize :ensure_cheer_count

  before_validation :ensure_session_token
  before_validation :ensure_cheer_count

  has_many :goals

  # Replaced with conerns/commentable module
  # has_many :comments, :as => :commentable

  has_many :cheers_given,
    primary_key: :id,
    foreign_key: :giver_id, 
    class_name: :Cheer
  
  # Through goals get the list of goals 
  # Source cheers get the list of cheers per goal
  has_many :cheers_received,
    through: :goals,
    source: :cheers

  attr_reader :password

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil unless user
    user.is_password?(password) ? user : nil
  end
  
  

  def password=(new_password)
    @password = new_password
    self.password_digest = BCrypt::Password.create(new_password)
  end

  def is_password?(maybe_password)
    BCrypt::Password.new(self.password_digest).is_password?(maybe_password)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token

    # Check if new token is unique
    while User.exists?(session_token: self.session_token)
      self.session_token = self.class.generate_session_token
    end

    self.save!
    self.session_token
  end

  def decrement_cheer_count!
    self.cheer_count -= 1 
    self.save!
  end

  def exceed_cheer_limit?
    self.cheer_count <= 0
  end

  private

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def ensure_cheer_count
    self.cheer_count ||= Cheer::CHEER_LIMIT
  end
  
end
