# frozen_string_literal: true

class HistoricalLoan < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  default_scope -> { order(:borrow_time) }
end
