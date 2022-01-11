class Loan < ApplicationRecord
  belongs_to :book
  belongs_to :user
  validates :book_id, presence: true
  validates :user_id, presence: true
end
