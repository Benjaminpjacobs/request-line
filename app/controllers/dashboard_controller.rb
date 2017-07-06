class DashboardController < ApplicationController
  def index
    if DateTime.now.to_time.to_i > session[:token_expiration]
      current_user.token = current_user.refresh_access_token
      session[:token_expiration] = session[:token_expiration] + 3600
    end
    @spotify_user = SpotifyUser.new(current_user)
  end
end