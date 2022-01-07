class BooksController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update, :create, :show]

  def new
    @book = Book.new
  end

  def edit
     @book = Book.find(params[:id])   
  end

  def index
  end

  def show
    @book = Book.find(params[:id])    
  end

  def create
    @book = Book.new(book_params)   
    if @book.save
      flash[:success] = "Książka została dodana."
      redirect_to @book
    else
      render 'new'
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success] = "Edycja udana"
      redirect_to @book
    else
      render 'edit'
    end
  end

  private

    def book_params
      params.require(:book).permit(:title, :author, :description)
    end

end
