class BooksController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update, :create, :show, :destroy]
  before_action :admin_user,     only: :destroy

  def destroy
    Book.find(params[:id]).destroy
    flash[:success] = "Książka została usunięta."
    redirect_to books_url
  end

  def new
    @book = Book.new
  end

  def edit
     @book = Book.find(params[:id])   
  end

  def index
    @books = Book.order('title').paginate(page: params[:page], per_page: 10)

    if params[:order] == 'title'
        @books = Book.order('title').paginate(page: params[:page], per_page: 10)
    elsif params[:order] == 'author'
        @books = Book.order('author').paginate(page: params[:page], per_page: 10)
    elsif params[:order] == 'price_mal'
        @books = Book.order('price DESC').paginate(page: params[:page], per_page: 10)
    elsif params[:order] == 'price_ros'
        @books = Book.order('price').paginate(page: params[:page], per_page: 10)
    else
        @books = Book.paginate(page: params[:page], per_page: 10)
    end
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
      params.require(:book).permit(:title, :author, :description, :price, :content)
    end

end
