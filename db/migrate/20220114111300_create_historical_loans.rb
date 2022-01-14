# frozen_string_literal: true

class CreateHistoricalLoans < ActiveRecord::Migration[6.1]
  def change
    create_table :historical_loans do |t|
      t.string :title
      t.string :author
      t.integer :price
      t.datetime :borrow_time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :historical_loans, %i[user_id created_at]
  end
end
