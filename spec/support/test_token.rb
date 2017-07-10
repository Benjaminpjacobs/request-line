require 'yaml'

class TestToken
  
  def self.refresh_token
    if DateTime.now.to_time.to_i > ENV['expiry'].to_i
      client_id_and_secret = Base64.strict_encode64("#{ENV['client_id']}:#{ENV['client_secret']}")
      test_env_vars = YAML.load_file "config/application.yml"
      test_env_vars["test"]["expiry"] = ENV['expiry'].to_i + 3600
      test_env_vars["test"]["spotify_access_token"] = SpotifyService.refresh_token(ENV['refresh_token'], client_id_and_secret)['access_token']
      File.open("config/application.yml", 'w') { |f| YAML.dump(test_env_vars, f) }
    end 
  end

end