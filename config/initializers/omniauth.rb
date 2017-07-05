Rails.application.config.middleware.use OmniAuth:Builder do
  provider :spotify, ENV['client_id'], ENV['client_secret'], scope: 'playlist-read-private user-read-private user-read-email'
end
