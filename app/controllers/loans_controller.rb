class LoansController < ApplicationController
	before_action :logged_in_user

  def create 
  	book = Book.find(params[:book_id])
    current_user.borrow(book)
    flash[:success] = "Wypożyczono książkę"
    redirect_to book
  end

  def destroy  
  	book = Loan.find(params[:id]).book
  	current_user.update_balance(book)
  	current_user.return(book)
  	flash[:success] = "Oddano książkę"
  	redirect_to current_user
  end
end
