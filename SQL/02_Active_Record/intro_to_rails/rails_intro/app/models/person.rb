class Person < ApplicationRecord
    # because we have the following in person schema
    # t.string :name, null: false
    # t.integer :house_id, null: false # use house instead of foreign key
    validates :name, :house, presence: true

    # Each person belongs to a house
    belongs_to :house, 
        primary_key: :id,
        foreign_key: :house_id,
        class_name: :House
end

# Notes:
# ::all
# ::column_names
# ::new
# ::first
# ::last
# ::find_by({option})
# ::find(id)
# ::create({option})

# # save
# # save!
# # destroy
# # valid?