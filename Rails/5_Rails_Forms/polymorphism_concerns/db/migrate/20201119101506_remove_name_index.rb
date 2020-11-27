class RemoveNameIndex < ActiveRecord::Migration[5.1]
  def change
    remove_index :toys, name: "index_toys_on_name"
  end
end
