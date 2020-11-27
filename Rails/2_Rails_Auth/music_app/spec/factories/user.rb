FactoryBot.define do
    factory :user do
        email { |n| Faker::Internet.Email }
        password { |p| Faker::Internet.Password }
    end
end