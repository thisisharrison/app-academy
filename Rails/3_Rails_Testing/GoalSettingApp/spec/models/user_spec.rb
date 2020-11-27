require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  subject(:user) {
    FactoryBot.create(:user,
      username: 'dummyuser',
      password: 'goodpassword'
    )
  }

  describe "validation" do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    # it { should validate_length_of(:password).is_at_least(6) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:session_token) }
    it { should have_many(:comments) }
    it { should have_many(:cheers_given) }
    it { should have_many(:cheers_received).through(:goals) }
  end

  describe "encrpytion" do
    it "does not save the password to database" do
      expect(user.password).not_to be('goodpassword')
    end
    it "uses BCrypt for encryption" do
      expect(BCrypt::Password).to receive(:create)
      User.new(username: 'abc', password: '123456')
    end
  end

  describe "#is_password?" do
    it "validates the right password" do
      expect(user.is_password?('goodpassword')).to be(true)
    end
    it "invalidates the wrong password" do
      expect(user.is_password?('badpassword')).to be(false)
    end
  end

  describe "#reset_session_token!" do
    it "sets new session token and returns it" do 
      old_token = user.session_token
      expect(user.reset_session_token!).not_to be(old_token)
    end
  end

  describe "::find_by_credentials" do
    before { user.save! }
    it "finds the right user with right credentials" do 
      expect(User.find_by_credentials(
        'dummyuser',
        'goodpassword'
      )).to eq(user)
    end
    it "returns nil if wrong credentials" do 
      expect(User.find_by_credentials(
        'whoisthis',
        'badpassword'
      )).to eq(nil)
    end
  end


end
