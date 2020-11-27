class Toy < ApplicationRecord
  # toyable creature should only have one toy with same name
  validates :name, uniqueness: { scope: [:toyable] }
  belongs_to :toyable, polymorphic: true
end
