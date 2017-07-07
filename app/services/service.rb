class Service
  
  def self.info(token)
    attrs = HTTParty.get(
    "https://api.spotify.com/v1/me",
    :headers => {"Authorization" => "Bearer #{token}"}
    ).parsed_response
    Info.new(attrs)
  end

  def self.playlists(token)
    HTTParty.get(
    "https://api.spotify.com/v1/me/playlists?limit=50",
    :headers => {"Authorization" => "Bearer #{token}"}
    ).parsed_response['items'].map do |playlist|
      Playlist.new(playlist)
    end
  end

  def self.playlist_song_search(user_id, playlist_id, token)
    HTTParty.get(
    "https://api.spotify.com/v1/users/#{user_id}/playlists/#{playlist_id}/tracks",
    :headers => {"Authorization" => "Bearer #{token}"}
    )
  end

  def self.song_search(query, token)
    HTTParty.get(
      "https://api.spotify.com/v1/search?q=#{query}&type=track&limit=10",
      :headers => {"Authorization" => "Bearer #{token}"}
      )
  end
end