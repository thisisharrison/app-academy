class ChaneCheerCountAgain < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :cheer_count
    add_column :users, :cheer_count, :integer,  null: false, default: Cheer::CHEER_LIMIT
  end
end
