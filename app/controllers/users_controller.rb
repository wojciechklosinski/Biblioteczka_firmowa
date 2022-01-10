class UsersController < ApplicationController

  before_action :logged_in_user, only: [:show, :index,:balance_reset]  
  before_action :correct_user,   only: [:show]
  before_action :admin_user,     only: [:index,:balance_reset]


  def index
    @users = User.order('name').paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def balance_reset
    User.find(params[:user_id]).reset_balance
    flash[:success] = "Zresetownao saldo"
    redirect_to users_url  
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user
      flash[:success] = "Poprawnie zalogowano"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end    
end
