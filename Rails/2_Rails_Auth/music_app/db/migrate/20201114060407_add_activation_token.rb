class AddActivationToken < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :activation_token, :string, null: false
    add_index :users, :activation_token, unique: true
  end
end
