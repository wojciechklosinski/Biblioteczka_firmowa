require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid add information" do
    get add_book_path
    assert_no_difference 'Book.count' do
      post books_path, params: { book: { title:  "",
                                         author: "",
                                         description: ""        } }
    end
    assert_template 'books/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end
end