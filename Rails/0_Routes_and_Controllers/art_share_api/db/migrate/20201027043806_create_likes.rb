class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :user_id, null: false
      t.references :likeable, polymorphic: true, index: true
      
      t.timestamps
    end
    # Replaced with indexing on combination of the 3
    # add_index :likes, :user_id

    # each user can only like once per like type (comment or artwork) 
    add_index :likes, [:likeable_id, :likeable_type, :user_id], unique: true
  end
end


# references produce:
# create_table :likes do |t|
#   t.integer :user_id, null: false
#   t.bigint :likeable_id
#   t.string :likeable_type 
#   t.timestamps
# end

# polymorph = two or more morph forms in the same species
# Like has Comment Type and Artwork Type. Both are Likes. Both given by a user. 