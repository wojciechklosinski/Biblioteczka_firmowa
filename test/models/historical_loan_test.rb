# frozen_string_literal: true

require 'test_helper'

class HistoricalLoanTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @historical_loan = @user.historical_loans.build
  end

  test 'should be valid' do
    assert @historical_loan.valid?
  end

  test 'user id should be present' do
    @historical_loan.user_id = nil
    assert_not @historical_loan.valid?
  end
end
