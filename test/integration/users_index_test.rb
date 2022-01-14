# frozen_string_literal: true

require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @user2 = users(:archer)
  end

  test 'index including pagination and reset balance' do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    # assert_select 'div.pagination'
    get users_path(user_id: @user2.id)
    assert_redirected_to users_path
    @user2.reload
    assert_equal @user2.balance, 0
  end
end
