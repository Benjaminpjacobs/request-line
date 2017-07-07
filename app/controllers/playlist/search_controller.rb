class Playlist::SearchController < ApplicationController
  def new
    song_results = Service.playlist_song_search(params[:user_id], params[:playlist_id], session[:access_token])
    render json: song_results['items']
  end
end