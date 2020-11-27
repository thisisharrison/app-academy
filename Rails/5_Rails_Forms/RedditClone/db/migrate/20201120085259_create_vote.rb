class CreateVote < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.integer :user_id, null: false
      t.integer :value, null: false
      t.references :votable, polymorphic: true, add_index: true
    end
    add_index :votes, :user_id
    add_index :votes, [:user_id, :votable_type, :votable_id], unique: true
  end
end
