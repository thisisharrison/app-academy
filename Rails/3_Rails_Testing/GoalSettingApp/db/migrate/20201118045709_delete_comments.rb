class DeleteComments < ActiveRecord::Migration[5.2]
  def change
    drop_table :comments
    create_table :comments do |t|
      t.integer :author_id
      t.text :body
      t.references :commentable, polymorphic: true
    
      t.timestamp
    end
    add_index :comments, :author_id
  end
end
