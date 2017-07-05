class User < ApplicationRecord

  def self.from_omniauth(auth_info)
    where(uid: auth_info[:uid]).first_or_create do |new_user|
      binding.pry
      new_user.uid = auth_info.uid
      new_user.name = auth_info.info.name
      new_user.email = auth_info.info.email
      new_user.refresh_token = auth_info.credentials.refresh_token
    end
  end

  def refresh_access_token
    client_id = ENV['client_id']
    client_secret = ENV['client_secret']
    client_id_and_secret = Base64.strict_encode64("#{client_id}:#{client_secret}")
    result = HTTParty.post(
    "https://accounts.spotify.com/api/token",
    :body => {:grant_type => "refresh_token",
              :refresh_token => "#{self.refresh_token}"},
    :headers => {"Authorization" => "Basic #{client_id_and_secret}"}
    )
    result.parsed_response['access_token']
  end
end
