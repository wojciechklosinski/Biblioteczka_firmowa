require "test_helper"

class BooksBorrowingAndReturningTest < ActionDispatch::IntegrationTest

  def setup
    @book      = books(:biblia)
    @book2     = books(:testowa)
    @admin     = users(:michael)
    @non_admin = users(:archer)
  end


  test "should not be able to borrow/return book if not logged in (checking buttons)" do
    get books_path
    assert_select 'a.btn-success', false
    assert_select 'input.btn-primary', false
    assert_select 'a.btn-warning', count: 10
    assert_no_difference '@admin.books.count' do
      post loans_path(book_id: @book.id)
    end
    @admin.borrow(@book)
    loan = @admin.loans.find_by(book_id: @book.id)
    assert_no_difference '@admin.books.count' do
      delete loan_path(loan)
    end
  end

  test "should be able to borrow/return/edit/delete book if logged in as admin(checking buttons)" do
    log_in_as(@admin)

    #strona profilu
    get user_path(@admin)
    assert_select 'a.btn-success',  0
    assert_select 'input.btn',  0

    #strona ksiazki
    get book_path(@book2)
    assert_select 'input.btn-primary',  1
    assert_select 'a[data-method="delete"]', text: 'usuń'

    #strona wszystkie ksiazki
    get books_path(order: 'title')
    assert_select 'a.btn-success',  0
    assert_select 'a.btn-warning',  10
    assert_select 'input.btn-primary',  10 
    assert_select 'a[data-method="delete"]', text: 'usuń'

    assert_difference '@admin.books.count',1 do
      post loans_path(book_id: @book2.id)
    end
    follow_redirect!
    assert_template 'books/show'
    assert_select 'div.alert-success'

    #strona wszystkie ksiazki
    get books_path(order: 'title')
    assert_select 'a.btn-success',  1
    assert_select 'a.btn-warning',  9
    assert_select 'input.btn-primary',  9 
    assert_select 'a[data-method="delete"]', text: 'usuń'

    #strona ksiazki
    get book_path(@book2)
    assert_select 'input.btn-primary',  0
    assert_select 'input.btn',  1
    assert_select 'a[data-method="delete"]', text: 'usuń'

    #strona profilu
    get user_path(@admin)
    assert_select 'a.btn-success',  1
    assert_select 'input.btn',  1

    get books_path(order: 'title')
    loan = @admin.loans.find_by(book_id: @book2.id)
    assert_difference '@admin.books.count', -1 do
      delete loan_path(loan)
    end

    #strona profilu
    get user_path(@admin)
    assert_select 'a.btn-success',  0
    assert_select 'input.btn',  0

    #strona ksiazki
    get book_path(@book2)
    assert_select 'input.btn-primary',  1
    assert_select 'a[data-method="delete"]', text: 'usuń'

    #strona wszystkie ksiazki
    get books_path(order: 'title')
    assert_select 'a.btn-success',  0
    assert_select 'a.btn-warning',  10
    assert_select 'input.btn-primary',  10 
    assert_select 'a[data-method="delete"]', text: 'usuń'
  end

  test "should be able to borrow/return book if logged in as nonadmin(checking buttons)" do
    log_in_as(@non_admin)

    assert_difference '@non_admin.books.count',1 do
      post loans_path(book_id: @book2.id)
    end
    follow_redirect!
    assert_template 'books/show'
    assert_select 'div.alert-success'

    loan = @non_admin.loans.find_by(book_id: @book2.id)
    assert_difference '@non_admin.books.count', -1 do
      delete loan_path(loan)
    end
  end
end
