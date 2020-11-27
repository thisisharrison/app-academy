class ChangeCheerCount < ActiveRecord::Migration[5.2]
  def change
    # remove the default = 0
    change_column :users, :cheer_count, :integer, null: false 
  end
end
