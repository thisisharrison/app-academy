class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :author_id
      t.text :body
      t.references :commetable, polymorphic: true
      # t.bigint :commentable_id
      # t.string :commentable_type

      t.timestamps
    end
    add_index :comments, :author_id
    # add_index :comments, [:commentable_type, :commentable_id]
  end
end
