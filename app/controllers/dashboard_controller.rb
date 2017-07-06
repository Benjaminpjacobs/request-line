class DashboardController < ApplicationController
  def index
    
    if DateTime.now.to_time.to_i > session[:token_expiration]
      session[:access_token] = current_user.refresh_access_token
      session[:token_expiration] = session[:token_expiration] + 3600
    end
    
    user_results = HTTParty.get(
    "https://api.spotify.com/v1/me",
    :headers => {"Authorization" => "Bearer #{session[:access_token]}"}
    )
    user_playlists = HTTParty.get(
    "https://api.spotify.com/v1/me/playlists?limit=50",
    :headers => {"Authorization" => "Bearer #{session[:access_token]}"}
    )
    binding.pry
    @user_info = JSON.parse(user_results.body)
    @user_playlists = JSON.parse(user_playlists.body)
  end
end