class Service
  
  def self.info(token)
    binding.pry
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
end