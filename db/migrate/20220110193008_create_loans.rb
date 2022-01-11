class CreateLoans < ActiveRecord::Migration[6.1]
  def change
    create_table :loans do |t|
      t.integer :user_id
      t.integer :book_id

      t.timestamps
    end
    add_index :loans, :user_id
    add_index :loans, [:user_id, :book_id], unique: true
  end 
end
