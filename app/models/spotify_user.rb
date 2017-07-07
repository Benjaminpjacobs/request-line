class SpotifyUser < SimpleDelegator
  
  def info
    @info ||= Service.info(token)
  end

  def playlists
    @playlists ||= Service.playlists(token)
  end
end