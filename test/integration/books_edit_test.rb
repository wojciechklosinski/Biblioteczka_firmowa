# frozen_string_literal: true

require 'test_helper'

class BooksEditTest < ActionDispatch::IntegrationTest
  def setup
    @book = books(:biblia)
    @user = users(:michael)
  end

  test 'unsuccessful book edit' do
    log_in_as(@user)
    get edit_book_path(@book)
    assert_template 'books/edit'
    patch book_path(@book), params: { book: { title: '',
                                              author: '',
                                              description: '',
                                              price: -1,
                                              content: '' } }

    assert_template 'books/edit'
  end

  test 'successful book edit' do
    get edit_book_path(@book)
    log_in_as(@user)
    assert_redirected_to edit_book_path(@book)
    patch book_path(@book), params: { book: { title: 'Książka',
                                              author: 'Wojtas',
                                              description: 'cokolwiek',
                                              price: 2,
                                              content: 'Zawartość' } }

    assert_not flash.empty?
    assert_redirected_to @book
    @book.reload
    assert_equal 'Książka', @book.title
    assert_equal 'Wojtas', @book.author
  end
end
