class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      reset_session
      remember user
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Niepoprawny email bądź hasło.'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
  
  # Zalogowanie lub stworzenie użytkownika z danymi pobranymi z konta google.
  def omniauth
    user = User.from_omniauth(auth)
    user.save
    reset_session
    remember user
    log_in user
    redirect_to user
  end

  private

    def auth
      request.env['omniauth.auth']
    end

end
