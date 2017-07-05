Rails.application.routes.draw do
  get '/auth/spotify', as: :spotify_login
  get '/auth/spotify/callback', to: 'sessions#create'
  get '/login', to: 'sessions#new'
end
