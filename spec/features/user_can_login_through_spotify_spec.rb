require 'rails_helper'

RSpec.feature 'User can login' do
  it "can login through spotify" do
  def setup
    Capybara.app = RequestLine::Application
  end
    stub_omniauth
    visit "/login"
    assert_equal 200, page.status_code
    click_link('Sign in with Spotify')
    expect(current_path).to  eq(dashboard_index_path)
    expect(page).to have_content("another_benjamin_jacobs")
    expect(page).to have_link("Logout")
  end

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
end
