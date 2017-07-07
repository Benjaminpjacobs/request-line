class Service

  def initialize(token)
    @token = token
  end

  def self.conn(query, token)
    HTTParty.get(
    "https://api.spotify.com/v1/#{query}",
    :headers => {"Authorization" => "Bearer #{token}"}
    ).parsed_response
  end
  
  def self.info(token)
    conn("me", token)
  end

  def self.playlists(token)
    query = 'me/playlists?limit=50'
    conn(query, token)['items']
  end

  def self.playlist_song_search(user_id, playlist_id, token)
    query = "users/#{user_id}/playlists/#{playlist_id}/tracks"
    conn(query, token)
  end

  def self.song_search(search, token)
    query = "search?q=#{search}&type=track&limit=10"
    conn(query, token)
  end

  def self.refresh_token(refresh_token, client_id_and_secret)
    HTTParty.post(
    "https://accounts.spotify.com/api/token",
    :body => {:grant_type => "refresh_token",
              :refresh_token => "#{self.refresh_token}"},
    :headers => {"Authorization" => "Basic #{client_id_and_secret}"}
    ).parsed_response
  end
end