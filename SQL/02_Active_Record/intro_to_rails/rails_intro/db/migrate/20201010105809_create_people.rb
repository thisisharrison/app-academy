class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.string :name, null: false
      t.integer :house_id, null: false

      t.timestamps
    end
    # foreign key is good choice for indexing, to use in WHERE and JOIN
    add_index :people, :house_id
  end
end
