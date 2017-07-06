class SearchController < ApplicationController
  def new
    query = params[:q]
    song_results = HTTParty.get(
    "https://api.spotify.com/v1/search?q=#{query}&type=track&limit=10",
    :headers => {"Authorization" => "Bearer #{session[:access_token]}"}
    )

    # if song_results.parsed_response['error']
    #   session[:access_token] = current_user.refresh_access_token
    #   redirect_to "/search?q=#{query}"
    # else
      # binding.pry
      render json: song_results.parsed_response['tracks']['items']
    # end

  end
end