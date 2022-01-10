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

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Book.count' do
      delete book_path(@book)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'Book.count' do
      delete book_path(@book)
    end
    assert_redirected_to root_url
  end

  test "add image" do
    log_in_as(@user)
    get new_book_path
    assert_select 'input[type=file]'
    image = fixture_file_upload('test/fixtures/kitten.jpg', 'image/jpeg')
    post books_path, params: { book:
                                  { title: "Fajowa ksiazka", 
                                    image: image,
                                    author: "Wojciech K",
                                    description: "no nie wiem co napisac" } }
    assert assigns(:book).image.attached?                               
  end
end
