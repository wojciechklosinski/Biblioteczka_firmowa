class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def edit
  end

  def index
  end

  def show
    @book = Book.find(params[:id])    
  end

  def create
    @book = Book.new(book_params)    # Not the final implementation!
    if @book.save
      # Handle a successful save.
    else
      render 'new'
    end
  end

  private

    def book_params
      params.require(:book).permit(:title, :author, :description)
    end
end
