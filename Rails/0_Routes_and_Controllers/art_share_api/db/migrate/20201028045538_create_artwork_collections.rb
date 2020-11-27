class CreateArtworkCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :artwork_collections do |t|
      t.integer :collection_id, null = false
      t.integer :artwork_id, null = false

      t.timestamps
    end
      # an artwork is in one collection once
      add_index :artwork_collections, [:artwork_id, :collection_id], unique: true
      add_index :artwork_collections, :artwork_id
      add_index :artwork_collections, :collection_id
  end
end
