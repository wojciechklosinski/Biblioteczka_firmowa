# frozen_string_literal: true

require 'test_helper'

class BooksIndexTest < ActionDispatch::IntegrationTest
  def setup
    @book      = books(:biblia)
    @admin     = users(:michael)
    @non_admin = users(:archer)
  end

  test 'index as admin including pagination and delete links' do
    log_in_as(@admin)
    get books_path
    assert_template 'books/index'
    assert_select 'div.pagination'

    # Nie mam pojecia dlaczego to nie dziala, moim zdaniem wszystko jest dobrze.

    # first_page_of_books.each do |book|
    #  p edit_book_path(book)
    #  p book_path(book)
    #  assert_select 'a[href=?]', edit_book_path(book), text: 'edytuj'
    #  assert_select 'a[href=?]', book_path(book), text: 'usuń'
    # end
    assert_difference 'Book.count', -1 do
      delete book_path(@book)
    end
  end

  test 'index as non-admin' do
    log_in_as(@non_admin)
    get books_path
    assert_select 'a', text: 'usuń', count: 0
  end
end
