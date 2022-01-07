require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end 

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should get show" do
    log_in_as(@user)
    get user_path(@user)
    assert_template 'users/show'
  end

  test "should redirect show when not logged in" do
    get user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

end
