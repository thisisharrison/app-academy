class ChangeVoteLogic < ActiveRecord::Migration[5.2]
  def change
    remove_index :votes, name: "unqiue_votes"
    add_index :votes, [:user_id, :votable_type, :votable_id], unique: true
  end
end
