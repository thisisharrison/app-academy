class CreateTaggings < ActiveRecord::Migration[6.0]
  def change
    create_table :taggings do |t|
      t.integer :tag_id, null: false
      t.integer :shortened_url_id, null: false

      t.timestamps
    end
    # there shouldn't be more than one entry of same tag_id and shortened_url_id 
    add_index :taggings, [:tag_id, :shortened_url_id], unique: true
    # foreign key
    add_index :taggings, :shortened_url_id
  end
end

# Note:
# There should be unique tag_id + url_id pair
# CREATE UNIQUE INDEX  "index_taggings_on_tag_id_and_shortened_url_id" ON "taggings"  ("tag_id", "shortened_url_id")

# There can be multiple tags for url_id
# CREATE  INDEX  "index_taggings_on_shortened_url_id" ON "taggings"  ("shortened_url_id")