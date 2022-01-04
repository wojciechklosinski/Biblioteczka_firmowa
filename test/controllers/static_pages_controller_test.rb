# frozen_string_literal: true

require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = 'Firmowa biblioteczka'
  end

  test 'should get root' do
    get root_path
    assert_response :success
    assert_select 'title', "#{@base_title}"
  end

  test 'should get about' do
    get about_path
    assert_response :success
    assert_select 'title', "About | #{@base_title}"
  end
end
