Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV['client_id'], ENV['client_secret'], scope: 'playlist-read-private playlist-read-collaborative playlist-modify-public playlist-modify-private user-library-read user-read-email'
end
