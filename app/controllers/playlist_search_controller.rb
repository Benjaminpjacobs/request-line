class PlaylistSearchController < ApplicationController
  def new
    user_id = params[:user_id]
    playlist_id = params[:playlist_id]
      song_results = HTTParty.get(
      "https://api.spotify.com/v1/users/#{user_id}/playlists/#{playlist_id}/tracks",
      :headers => {"Authorization" => "Bearer #{session[:access_token]}"}
      )
      render json: song_results.parsed_response['items']
  end
end