class Song::SearchController < ApplicationController
  def new
    query = params[:q]
    unless query.nil? || query.empty?
      song_results = HTTParty.get(
      "https://api.spotify.com/v1/search?q=#{query}&type=track&limit=10",
      :headers => {"Authorization" => "Bearer #{session[:access_token]}"}
      )
      render json: song_results.parsed_response['tracks']['items']
    end
  end
end