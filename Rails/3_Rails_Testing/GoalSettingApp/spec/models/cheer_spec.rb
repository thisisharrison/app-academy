require 'rails_helper'

RSpec.describe Cheer, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it { should belong_to(:goal) }
  it { should belong_to(:giver) }
end
