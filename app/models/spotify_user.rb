class SpotifyUser < SimpleDelegator
  
  def info
    @info ||= Info.user_info(token)

  end

  def playlists
    @playlists ||= Playlist.user_playlists(token)
  end
end