require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest

  def setup
    @book = books(:biblia)
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "should redirect edit when not logged in" do
    get edit_book_path(@book)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch book_path(@book), params: { book: { title: @book.title,
                                              author: @book.author } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect new when not logged in" do
    post books_path, 		params: { book: { title: @book.title,
                                              author: @book.author } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect show when not logged in" do
    patch book_path(@book)
    assert_not flash.empty?
    assert_redirected_to login_url
  end
end
