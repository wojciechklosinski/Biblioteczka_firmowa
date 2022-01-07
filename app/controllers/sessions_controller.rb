class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      forwarding_url = session[:forwarding_url]     
      reset_session
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      log_in user
      redirect_to forwarding_url || user
    else
      flash.now[:danger] = 'Niepoprawny email bądź hasło.'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
  
  # Zalogowanie lub stworzenie użytkownika z danymi pobranymi z konta google.
  def omniauth
      forwarding_url = session[:forwarding_url]   
      user = User.from_omniauth(auth)
      user.save
      reset_session
      remember(user)
      log_in user
      redirect_to forwarding_url || user
  end

  private

    def auth
      request.env['omniauth.auth']
    end

end
