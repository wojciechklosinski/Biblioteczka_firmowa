# frozen_string_literal: true

require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test 'invalid add information' do
    log_in_as(@user)
    get add_book_path
    assert_no_difference 'Book.count' do
      post books_path, params: { book: { title: '',
                                         author: '',
                                         description: '',
                                         price: -2,
                                         content: '' } }
    end
    assert_template 'books/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test 'valid add information' do
    log_in_as(@user)
    get add_book_path
    assert_difference 'Book.count', 1 do
      post books_path, params: { book: { title: 'Ciekawa księga',
                                         author: 'Wojtek',
                                         description: 'O losie ale dobra.',
                                         price: 2,
                                         content: 'Zawartość' } }
    end
    follow_redirect!
    assert_template 'books/show'
  end
end
