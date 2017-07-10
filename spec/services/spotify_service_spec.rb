require 'rails_helper'
require 'support/test_token'

describe SpotifyService do
  context ".info" do
    it "returns a hash of user data" do
      # TestToken.refresh_token
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

  context ".playlists" do
    it "returns a hash of playist data" do
      # TestToken.refresh_token
      VCR.use_cassette("services/user_playlists") do
        user_playlists = SpotifyService.playlists(ENV['spotify_access_token'])
        user_playlist = user_playlists.first

        expect(user_playlists.count).to eq(5)
        expect(user_playlist).to have_key('external_urls')
        expect(user_playlist).to have_key('href')
        expect(user_playlist).to have_key('id')
        expect(user_playlist).to have_key('images')
        expect(user_playlist['images']).to be_an Array
        expect(user_playlist).to have_key('name')
        expect(user_playlist).to have_key('owner')
        expect(user_playlist['owner']).to have_key('id')
        expect(user_playlist['owner']).to have_key('href')
        expect(user_playlist['owner']).to have_key('uri')
      end
    end
  end
  
  context ".playlist_song_search" do
    it "returns playist song data" do
      # TestToken.refresh_token
      VCR.use_cassette("services/user_playlist_songs") do
        playlist_songs = SpotifyService.playlist_song_search("another_benjamin_jacobs", "3B6onVfcQRLy40kGSzNgaP", ENV['spotify_access_token'])
        playlist_song = playlist_songs['items'].first
        track = playlist_song['track']
        album = track['album']
        artists = track['artists']
        
        expect(playlist_songs.count).to eq(7)
        expect(playlist_songs).to have_key('items')

        expect(playlist_song).to have_key('track')

        expect(track).to have_key('album')
        expect(track).to have_key('artists')
        expect(track).to have_key('id')
        expect(track).to have_key('name')

        expect(album).to have_key('name')

        expect(artists.first).to have_key('name')
        expect(artists.first).to have_key('id')

      end
    end
  end
  
  context ".song_search" do
    it "returns array of song data" do
      # TestToken.refresh_token
      VCR.use_cassette("services/song_search") do
        songs = SpotifyService.song_search("all along the watchtower", ENV['spotify_access_token'])
        song = songs['tracks']['items'].first
        artist = song['artists'].first
        album = song['album']

        expect(songs).to have_key('tracks')
        expect(songs['tracks']).to have_key('items')
        expect(song).to have_key('album')
        expect(song).to have_key('artists')
        expect(song).to have_key('id')
        expect(song).to have_key('name')
        expect(song).to have_key('uri')

        expect(artist).to have_key('name')
        expect(artist).to have_key('id')

        expect(album).to have_key('name')
        expect(album).to have_key('id')

      end
    end
  end
  context ".update_playlist" do
    it "returns affirmative of playlist alteration" do
      # TestToken.refresh_token
      VCR.use_cassette("services/update_playlist") do
        ss = SpotifyService.new(ENV['spotify_access_token'], 
                                {:user_id=> ENV['user_id'], 
                                 :playlist_id=> ENV['playlist_id'], 
                                 :song_id=>"0lumpxVA1X4ljriwwnszAA"}
                                 )
        result = ss.update_playlist.response


        expect(result).to be_an Object
        expect(result.msg).to eq('Created')
        expect(result.code).to eq('201')

      end
    end
  end
end
