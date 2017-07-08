class SpotifyService

  def initialize(token, params={})
    @token = token
    @conn = Faraday.new :url => 'https://api.spotify.com/v1', :headers => {"Authorization" => "Bearer #{@token}"}
    @user_id = params[:user_id] || nil
    @playlist_id = params[:playlist_id] || nil
    @song_id = params[:song_id] || nil
    @search = params[:search] || nil

  end

  def self.info(token)
    new(token).info
  end

  def self.playlists(token)
    new(token).playlists
  end

  def self.playlist_song_search(user_id, playlist_id, token)
    new(token, {user_id: user_id, playlist_id: playlist_id}).playlist_song_search
  end
  
  def self.song_search(search, token)
    new(token, {search: search}).song_search
  end

  def self.update_playlist(request, user)
    new(user.token, {user_id: user.uid, playlist_id: request.playlist_id, song_id: request.song_id}).update_playlist
  end

  def info
    response = @conn.get('me')
    JSON.parse(response.body)
  end

  def playlists
    response = @conn.get('me/playlists', {limit: 50})
    JSON.parse(response.body)['items']
  end

  def playlist_song_search
    response = @conn.get("users/#{@user_id}/playlists/#{@playlist_id}/tracks")
    JSON.parse(response.body)
  end

  def song_search
    response = @conn.get("search", {q: @search, type: "track", limit: 20})
    JSON.parse(response.body)
  end

  def update_playlist
    result = HTTParty.post(
    "https://api.spotify.com/v1/users/#{@user_id}/playlists/#{@playlist_id}/tracks?uris=spotify%3Atrack%3A#{@song_id}",
    :headers => {"Authorization" => "Bearer #{@token}"}
    )
    result.response.message
    
  end

  def self.refresh_token(refresh_token, client_id_and_secret)
    result = HTTParty.post(
    "https://accounts.spotify.com/api/token",
    :body => {:grant_type => "refresh_token",
              :refresh_token => "#{refresh_token}"},
    :headers => {"Authorization" => "Basic #{client_id_and_secret}"}
    )
   result.parsed_response
  end
end