# frozen_string_literal: true

require 'test_helper'

class HistoricalLoansControllerTest < ActionDispatch::IntegrationTest
  test 'should redirect when not logged in' do
    get historical_loans_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end
end
