class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.string :author

      t.timestamps
    end
    add_index :books, :title
    add_index :books, :author
  end
end
