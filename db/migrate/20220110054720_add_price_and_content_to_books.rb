# frozen_string_literal: true

class AddPriceAndContentToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :price, :integer
    add_column :books, :content, :text
    add_index :books, :price
  end
end
