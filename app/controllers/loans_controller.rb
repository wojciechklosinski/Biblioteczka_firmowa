class LoansController < ApplicationController
	before_action :logged_in_user

  def create
  	forwarding_url = session[:forwarding_url]  
  	book = Book.find(params[:book_id])
    current_user.borrow(book)
    redirect_to book
  end

  def destroy
  	forwarding_url = session[:forwarding_url]  
  	book = Loan.find(params[:id]).book
  	current_user.update_balance(book)
  	current_user.return(book)
  	redirect_to current_userr
  end
end
