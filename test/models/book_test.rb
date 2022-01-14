# frozen_string_literal: true

require 'test_helper'

class BookTest < ActiveSupport::TestCase
  def setup
    @book = Book.new(title: 'Lorem ipsum', description: 'Bardzo ciekawa książka.', author: 'Wojtas', price: 2,
                     content: 'Zawartość')
  end

  test 'should be valid' do
    assert @book.valid?
  end

  test 'title should be present' do
    @book.title = '   '
    assert_not @book.valid?
  end

  test 'author should be present' do
    @book.author = '   '
    assert_not @book.valid?
  end

  test 'content should be present' do
    @book.content = '   '
    assert_not @book.valid?
  end

  test 'author should not be too long' do
    @book.author = 'a' * 51
    assert_not @book.valid?
  end

  test 'title should not be too long' do
    @book.title = 'a' * 101
    assert_not @book.valid?
  end

  test 'title should be unique' do
    duplicate_book = @book.dup
    @book.save
    assert_not duplicate_book.valid?
  end

  test 'price should be greater than -1' do
    @book.price = -1
    assert_not @book.valid?
  end
end
