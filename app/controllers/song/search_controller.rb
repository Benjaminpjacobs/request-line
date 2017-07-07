class Song::SearchController < ApplicationController
  def new
    query = params[:q]
    unless query.nil? || query.empty?
      song_results = Service.song_search(query, session[:access_token])
      render json: song_results['tracks']['items']
    end
  end
end