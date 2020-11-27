class ChangeVoteIndex < ActiveRecord::Migration[5.2]
  def change
    remove_index :votes, name: "index_votes_on_user_id_and_votable_type_and_votable_id"
    add_index :votes, [:user_id, :value, :votable_type, :votable_id], unique: true, name: "unqiue_votes"
  end
end
