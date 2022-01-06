require "test_helper"

class BookTest < ActiveSupport::TestCase

  def setup
    @book = Book.new(title: "Lorem ipsum", description: "Bardzo ciekawa książka.", author: "Wojtas")
  end

  test "should be valid" do
    assert @book.valid?
  end

  test "title should be present" do
    @book.title = "   "
    assert_not @book.valid?
  end

  test "author should be present" do
    @book.author = "   "
    assert_not @book.valid?
  end

end
