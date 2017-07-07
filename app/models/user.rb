class User < ApplicationRecord

  def self.from_omniauth(auth_info)
    new_user = find_or_initialize_by(uid: auth_info[:uid])
    new_user.uid = auth_info.uid
    new_user.name = auth_info.info.name
    new_user.email = auth_info.info.email
    new_user.token = auth_info.credentials.token
    new_user.refresh_token = auth_info.credentials.refresh_token
    new_user.save
    new_user
  end

  def refresh_access_token
    client_id = ENV['client_id']
    client_secret = ENV['client_secret']
    client_id_and_secret = Base64.strict_encode64("#{client_id}:#{client_secret}")
    binding.pry
    result = SpotifyService.refresh_token(refresh_token, client_id_and_secret)
    result['access_token']
  end
end
