# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[show index]
  before_action :correct_user,   only: [:show]
  before_action :admin_user,     only: [:index]

  def index
    @users = User.order('name').paginate(page: params[:page])
    if params[:user_id]
      User.find(params[:user_id]).reset_balance
      flash[:success] = 'Zresetownao saldo'
      redirect_to users_url
    end
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user
      flash[:success] = 'Poprawnie zalogowano'
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
