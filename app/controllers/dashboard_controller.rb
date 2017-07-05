class DashboardController < ApplicationController
  def index
    current_user.refresh_access_token
    user_results = HTTParty.get(
    "https://api.spotify.com/v1/me",
    :headers => {"Authorization" => "Bearer #{session[:access_token]}"}
    )
    user_playlists = HTTParty.get(
    "https://api.spotify.com/v1/me/playlists",
    :headers => {"Authorization" => "Bearer #{session[:access_token}"}
    )

    binding.pry
    # if user_results.parsed_response['error']
    #   redirect_to dashboard_index_path
    # else
      @user_info = JSON.parse(user_results.body)
      @user_playlists = JSON.parse(user_playlists.body)['items']
    # end
  end
end