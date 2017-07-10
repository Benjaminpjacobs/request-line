# require 'rails_helper'
# require 'support/omniauth_helper'

# RSpec.feature 'User can make request' do
#   it "clicks request link and is led to song search", :js => true do
#     # TestToken.refresh_token
#     VCR.use_cassette("features/user_can_make_request/song_search") do
#       stub_omniauth      
#       visit "/request/new"
#       expect(current_path).to eq('/request/new')
#       fill_in :song_query, with: "All Along The Watch Tower"
#       click_button('Song Search')
#       sleep 10
#       expect(page).to have_content('All Along The Watch Tower')
#     end
#   end
# end
