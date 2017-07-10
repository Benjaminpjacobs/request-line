  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:spotify] = OmniAuth::AuthHash.new({
      provider: 'spotify',
      uid: 'another_benjamin_jacobs',
      info: {
        name: "another_benjamin_jacobs",
        urls: {"spotify"=>"https://open.spotify.com/user/another_benjamin_jacobs"},
        image: nil
      },
      credentials: {
        token: ENV['spotify_access_token'],
        refresh_token: ENV['spotify_refresh_token'],
        expires_at: DateTime.now.to_time.to_i + 3600,
      }
    })
  end