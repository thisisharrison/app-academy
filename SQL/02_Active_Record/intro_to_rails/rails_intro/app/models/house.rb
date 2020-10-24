class House < ApplicationRecord
    validates :address, presence: true

    # Houses can have many residents 
    has_many :residents,
        primary_key: :id,
        foreign_key: :house_id,
        class_name: :Person

end

# Notes:
# > person.house
# => #<House:0x00007fba14410f98
#  id: 1,
#  address: "App Academy",
#  created_at: Sun, 11 Oct 2020 07:29:18 UTC +00:00,
#  updated_at: Sun, 11 Oct 2020 07:29:18 UTC +00:00>

# > house.residents
#   Person Load (0.4ms)  SELECT "people".* FROM "people" WHERE "people"."house_id" = $1  [["house_id", 1]]
# => [#<Person:0x00007fba103bf6d8
#   id: 1,
#   name: "Harrison",
#   house_id: 1,
#   created_at: Sun, 11 Oct 2020 07:30:35 UTC +00:00,
#   updated_at:
#    Sun, 11 Oct 2020 07:30:35 UTC +00:00>]
