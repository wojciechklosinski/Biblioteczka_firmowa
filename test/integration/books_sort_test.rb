require "test_helper"

class BooksSortTest < ActionDispatch::IntegrationTest

  def setup
    @book = books(:biblia)
    @user = users(:michael)    
  end

end
