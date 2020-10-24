class CreateShortenedUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :shortened_urls do |t|
        t.string :long_url, null: false
        t.string :short_url, null: false
        t.integer :submitter_id, null: false

        t.timestamps
    end
    
    # index for short_url because we'll "look up" short_url to get long_url later 
    add_index :shortened_urls, :short_url, unique: true
    # index for submitter_id which is a foreign key
    add_index :shortened_urls, :submitter_id
  end
end
