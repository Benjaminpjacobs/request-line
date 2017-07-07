require 'rails_helper'
require 'support/omniauth_helper'

RSpec.feature 'User can login' do
  it "can login through spotify" do
    VCR.use_cassette("features/user_can_log_in") do

      def setup
        Capybara.app = RequestLine::Application
      end

      stub_omniauth      

      visit "/login"
      assert_equal 200, page.status_code
      click_link('Sign in with Spotify')
      
      expect(current_path).to  eq(dashboard_index_path)
      
      expect(page).to have_link("Logout")
      expect(page).to have_link("Go To Spotify")
      
      expect(page).to have_content("another_benjamin_jacobs")
      expect(page).to have_content("alt ben playlist")
      expect(page).to have_content("WorkoutPop")
      expect(page).to have_content("HalfMarathon")
    end
  end
end
