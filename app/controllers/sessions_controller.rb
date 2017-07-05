class SessionsController < ApplicationController
  def new
  end

  def create
    if user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = user.id
      session[:access_token] = request.env['omniauth.auth'].credentials.token
    end
    redirect_to dashboard_index_path
  end

  def destroy
    reset_session
    redirect_to login_path
  end
end