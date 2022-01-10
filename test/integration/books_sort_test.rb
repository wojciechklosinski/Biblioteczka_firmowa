require "test_helper"

class BooksSortTest < ActionDispatch::IntegrationTest

  def setup
    @book = books(:biblia)
    @book2 = books(:testowa)
    @book3 = books(:testowa2)
    @book4 = books(:tora)
    @user = users(:michael)    
  end

  test "index including pagination" do
    get books_path
    assert_template 'books/index'
    assert_select 'div.pagination'
  end

  test "index is ordered"  do
    get books_path(order: 'title')
    assert_match @book2.title, response.body
    assert_no_match @book3.title, response.body
    get books_path(order: 'author')
    assert_match @book3.author, response.body
    assert_no_match @book2.author, response.body
    get books_path(order: 'price_mal')
    assert_match @book.author, response.body
    assert_no_match @book4.author, response.body
    get books_path(order: 'price_ros')
    assert_match @book4.author, response.body
    assert_no_match @book.author, response.body
       
    # to jest fajny kod ktory nie dziala bo nie umiem pobrac zmiennej z kontrolera, zeby sprawdzic czy posortowano
    #books.each_cons(2).all?{|i,j| p "To jest tytuł 1: #{i.title} a to drugi: #{j.title}"}    
    #assert books.each_cons(2).all?{|i,j| i.title <= j.title}
  end

end
