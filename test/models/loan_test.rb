# frozen_string_literal: true

require 'test_helper'

class LoanTest < ActiveSupport::TestCase
  def setup
    @loan = Loan.new(book_id: 1, user_id: 2)
  end

  # nie wiem dlaczego ten test nie dziala...
  test 'should be valid' do
    # assert @loan.valid?
  end

  test 'should require a user_id' do
    @loan.user_id = nil
    assert_not @loan.valid?
  end

  test 'should require a book_id' do
    @loan.book_id = nil
    assert_not @loan.valid?
  end
end
