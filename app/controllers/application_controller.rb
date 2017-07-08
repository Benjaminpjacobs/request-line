class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :spotify_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def spotify_user
    @spotify_uswer ||= SpotifyUser.new(current_user) if current_user
  end
end
