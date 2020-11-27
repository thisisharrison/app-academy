FactoryBot.define do
  factory :goal do
    title { Faker::Lorem.characters(number: 10) }
    details { Faker::Lorem.characters(number: 20) }
  end
end
