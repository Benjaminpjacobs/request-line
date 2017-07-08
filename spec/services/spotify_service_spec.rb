require 'rails_helper'
require 'support/test_token'

describe SpotifyService do
  context ".info" do
    it "returns a hash of user data" do
      TestToken.refresh_token
      VCR.use_cassette("services/user_info") do
        user_info = SpotifyService.info(ENV['spotify_access_token'])
        
        expect(user_info).to have_key('display_name')
        expect(user_info).to have_key('email')
        expect(user_info).to have_key('external_urls')
        expect(user_info['external_urls']).to have_key('spotify')
        expect(user_info).to have_key('href')
        expect(user_info).to have_key('id')
        expect(user_info).to have_key('images')
        expect(user_info['images']).to be_an Array
        expect(user_info).to have_key('type')
        expect(user_info).to have_key('uri')
      end
    end
  end
end
