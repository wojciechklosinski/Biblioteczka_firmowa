# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :logged_in_user, only: %i[edit update create show destroy]
  before_action :admin_user,     only: :destroy

  def destroy
    Book.find(params[:id]).destroy
    flash[:success] = 'Książka została usunięta.'
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

    @books = case params[:order]
             when 'title'
               Book.order('title').paginate(page: params[:page], per_page: 10)
             when 'author'
               Book.order('author').paginate(page: params[:page], per_page: 10)
             when 'price_mal'
               Book.order('price DESC').paginate(page: params[:page], per_page: 10)
             when 'price_ros'
               Book.order('price').paginate(page: params[:page], per_page: 10)
             else
               Book.paginate(page: params[:page], per_page: 10)
             end
  end

  def show
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:success] = 'Książka została dodana.'
      redirect_to @book
    else
      render 'new'
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success] = 'Edycja udana'
      redirect_to @book
    else
      render 'edit'
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :description, :price, :content, :image)
  end
end
