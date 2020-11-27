require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  subject(:user) do 
    FactoryBot.build(:user,
      email: 'example@example.com',
      password: 'password123'
    )
  end

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_length_of(:password).is_at_least(6) }

  describe "#is_password?" do
    it "verifies a password is correct" do
      expect(user.is_password?('password123')).to be true
    end
    it "verifies a password is incorrect" do
      expect(user.is_password?('password890')).to be false
    end
  end
  
  describe "#reset_session_token!" do 
    it "sets new session token and returns session token" do
      org_token = user.session_token
      expect(user.reset_session_token!).to_not eq(org_token)
    end
  end

  describe "::find_by_credentials" do 
    # saves subject to DB so we can query for these test cases
    # or FactoryBot.create() to save to DB
    before { user.save! }

    it "returns users with right credentials" do
      expect(User.find_by_credentials('example@example.com', 
                                    'password123')).to eq(user)
    end

    it "returns nil with wrong credentials" do 
      expect(User.find_by_credentials('fake@example.com', 
                                    'password890')).to eq(nil)
    end
  end
end
