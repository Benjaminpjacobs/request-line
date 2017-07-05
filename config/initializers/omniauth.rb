Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV['client_id'], ENV['client_secret'], scope: 'playlist-modify-public playlist-modify-private user-read-email'
end
