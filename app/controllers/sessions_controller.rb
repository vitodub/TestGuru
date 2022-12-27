class SessionsController < ApplicationController

  skip_before_action :authenticate_user!

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      session[:intended_url].nil? ? redirect_to(tests_path)
      : redirect_to(session[:intended_url])
    else
      flash.now[:alert] = 'Ты Guru? Пожалуйста, подтверди свой email и пароль'
      render :new
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to login_path
  end
  
end
