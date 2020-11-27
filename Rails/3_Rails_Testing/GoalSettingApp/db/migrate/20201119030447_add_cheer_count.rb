class AddCheerCount < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :cheer_count, :integer,  null: false, default: 0
  end
end
