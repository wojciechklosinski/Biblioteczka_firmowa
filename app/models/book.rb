class Book < ApplicationRecord
  validates :author, presence: true, length: { maximum: 50 }
  validates :title, presence: true, length: { maximum: 100 }, uniqueness: true	
  validates :price, presence: true,  numericality: { greater_than_or_equal_to: 0 }
  validates :content, presence: true
end
