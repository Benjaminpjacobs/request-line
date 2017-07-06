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
    binding.pry
    expect(current_path).to  eq(dashboard_index_path)
    expect(page).to have_content("Horace")
    expect(page).to have_link("Logout")
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:spotify] = OmniAuth::AuthHash.new({
      provider: 'spotify',
      info: {
        user_id: "1234",
        name: "Horace Warren",
        email: "worace@gmail"
      },
      credentials: {
        token: "pizza",
        refresh_token: "secretpizza"
      }
    })
  end
end
